// ===========Oooo==========================================Oooo========
// =  Copyright (C) 2014 Shanghai Gowin Semiconductor Technology Co.,Ltd.
// =                     All rights reserved.
// =====================================================================
//
//  __      __      __
//  \ \    /  \    / /   [File name   ] gowin_pcie_bar_chdev.v
//   \ \  / /\ \  / /    [Description ] Source file for PCIE BAR driver
//    \ \/ /  \ \/ /     [Timestamp   ] 2022/11/30
//     \  /    \  /      [version     ] 1.0
//      \/      \/       
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Ver: | Author        | Mod. Date  | Changes Made:
// V1.0 | Huang Mingtao | 2022/11/30 | Initial version
// ===========Oooo==========================================Oooo========

#include <linux/module.h>
#include <linux/kernel.h>

#include <linux/cdev.h>
#include <linux/pci.h>
#include <linux/spinlock.h>
#include <linux/wait.h>


#include "../include/gowin_pcie_bar_drv_uapi.h"

// #ifndef RDMA_CH_NUM
// #define RDMA_CH_NUM         2
// #endif
// #ifndef WDMA_CH_NUM
// #define WDMA_CH_NUM         2
// #endif

#define GW_IRQ_NUM          (RDMA_CH_NUM + WDMA_CH_NUM)

#define MAX_DMA_CTX_NUM     256

#ifndef PCI_STD_NUM_BARS
//! DO NOT modify it
#define PCI_STD_NUM_BARS    6
#endif

#define CLASS_NAME "gowin"
#define DRIVER_NAME "gowin_pcie_demo"
#define DRIVER_VERSION "0.1"


#define VMEM_FLAGS (VM_IO | VM_DONTEXPAND | VM_DONTDUMP)

struct dma_context {
    void       *vir;
    dma_addr_t  phy;
    size_t      len;
};


struct gowin_bar_data {
    struct pci_dev         *pdev;
    // void   __iomem          *base;
    // void   __iomem          *bar[PCI_STD_NUM_BARS];

    struct cdev             gw_cdev;
    dev_t                   gw_devid;
    struct class           *gw_class;
    struct device          *gw_device;

    const char             *name;
    spinlock_t              lock;
    int                     open_cnt;

    struct dma_context      dma_ctx[MAX_DMA_CTX_NUM];

    int                     mem_select;
    int                     cur_bar;
    int                     cur_dma;

    int                     irq_number[GW_IRQ_NUM];
    atomic64_t              irq_count[GW_IRQ_NUM];
    wait_queue_head_t       irq_wait[GW_IRQ_NUM];

    /*! mutex to protect the iotcl */
    struct mutex            mutex;

    //! ????
    // size_t              alignment;
    struct gowin_iotcl_param *test;
};

static int msi_number   = 1;
static int drvOccupied  = 0;

/*!
 * gowin_readl() -
 *      static inline function that provides common BAR DWORD reading
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[in]   bar:    bar number
 * @param[in]   offset: bar register offset
 */
static inline u32 gowin_readl(
            struct gowin_bar_data *data, u32 bar, u32 offset)
{
    if (WARN_ON(bar >= PCI_STD_NUM_BARS)) {
        return 0;
    }
    else {
        return readl(pcim_iomap_table(data->pdev)[bar] + offset);
    }
}

/*!
 * gowin_writel() -
 *      static inline function that provides common BAR DWORD writing
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[in]   bar:    bar number
 * @param[in]   offset: bar register offset
 * @param[in]   value:  value to be written
 */
static inline void gowin_writel(
        struct gowin_bar_data *data, u32 bar, u32 offset, u32 value)
{
    if (WARN_ON(bar >= PCI_STD_NUM_BARS)) {
        return;
    }
    else  {
        writel(value, pcim_iomap_table(data->pdev)[bar] + offset);
    }
}

/*!
 * gowin_readw() -
 *      static inline function that provides common BAR WORD reading
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[in]   bar:    bar number
 * @param[in]   offset: bar register offset
 */
static inline u16 gowin_readw(
            struct gowin_bar_data *data, u32 bar, u32 offset)
{
    if (WARN_ON(bar >= PCI_STD_NUM_BARS)) {
        return 0;
    }
    else {
        return readw(pcim_iomap_table(data->pdev)[bar] + offset);
    }
}

/*!
 * gowin_writew() -
 *      static inline function that provides common BAR WORD writing
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[in]   bar:    bar number
 * @param[in]   offset: bar register offset
 * @param[in]   value:  value to be written
 */
static inline void gowin_writew(
        struct gowin_bar_data *data, u32 bar, u32 offset, u16 value)
{
    if (WARN_ON(bar >= PCI_STD_NUM_BARS)) {
        return;
    }
    else  {
        writew(value, pcim_iomap_table(data->pdev)[bar] + offset);
    }
}

/*!
 * gowin_readb() -
 *      static inline function that provides common BAR BYTE reading
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[in]   bar:    bar number
 * @param[in]   offset: bar register offset
 */
static inline u8 gowin_readb(
            struct gowin_bar_data *data, u32 bar, u32 offset)
{
    if (WARN_ON(bar >= PCI_STD_NUM_BARS)) {
        return 0;
    }
    else {
        return readb(pcim_iomap_table(data->pdev)[bar] + offset);
    }
}

/*!
 * gowin_writeb() -
 *      static inline function that provides common BAR BYTE writing
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[in]   bar:    bar number
 * @param[in]   offset: bar register offset
 * @param[in]   value:  value to be written
 */
static inline void gowin_writeb(
        struct gowin_bar_data *data, u32 bar, u32 offset, u8 value)
{
    if (WARN_ON(bar >= PCI_STD_NUM_BARS)) {
        return;
    }
    else  {
        writeb(value, pcim_iomap_table(data->pdev)[bar] + offset);
    }
}


static irqreturn_t gowin_bar_irq_handler(int irq, void *dev_id)
{
    int i;
    int id;
    u32 rval;
    struct gowin_bar_data *data = dev_id;

    if (unlikely(msi_number <= 0)) {
        return IRQ_NONE;
    }
    else if (msi_number == 1) {
        //! read IRQ status
        do {
            rval = gowin_readl(data, 0, 0x010);
        } while(rval == 0xFFFFFFFF);
        while (rval > 0) {
            //! clear IRQ right now
            gowin_writel(data, 0, 0x010, rval);
            gowin_readl(data, 0, 0);    //! flush write
            id = 0;
            for (i = 0; i < RDMA_CH_NUM; i++) {
                if (rval & (1<<i)) {
                    // printk(KERN_INFO "rval 0x%08x (%d)\n", rval, id);
                    atomic64_inc(&data->irq_count[id]);
	                wake_up_interruptible(&data->irq_wait[id]);
                }
                id++;
            }
            for (i = 0; i < WDMA_CH_NUM; i++) {
                if (rval & (1<<(i+16))) {
                    atomic64_inc(&data->irq_count[id]);
	                wake_up_interruptible(&data->irq_wait[id]);
                }
                id++;
            }
            //! Reread IRQ status
             do {
                rval = gowin_readl(data, 0, 0x010);
            } while(rval == 0xFFFFFFFF);
        }
    }
    else {
        for (id = 0; id < GW_IRQ_NUM; id++) {
            if (data->irq_number[id] == irq) break;
        }
        if (unlikely(id >= GW_IRQ_NUM)) {
            return IRQ_NONE;
        }
        atomic64_inc(&data->irq_count[id]);
	    wake_up_interruptible(&data->irq_wait[id]);
    }
    // printk(KERN_INFO "IRQ.........%lld", atomic64_read(&data->irq_count[i]));
    return IRQ_HANDLED;
}

/*!
 * ioctl_read_bar() -
 *      static function for iotcl: GOWIN_BAR_READ_DWORD
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_read_bar(
        struct gowin_bar_data *data, unsigned long arg)
{
    struct gowin_iotcl_param param;
    struct device *dev;

    if (WARN_ON(!data) || WARN_ON(!data->pdev) || WARN_ON(!arg))
        return -EINVAL;
    dev = &data->pdev->dev;

    if (copy_from_user(&param, (void __user *)arg, sizeof(param)))
        return -EFAULT;

    dev_dbg(dev, "Read BAR.\n");
    if (param.bar_idx >= PCI_STD_NUM_BARS)
        return -EINVAL;

    if (pci_resource_len(data->pdev, param.bar_idx) == 0) {
        dev_err(dev, "#%d BAR not available.\n", param.bar_idx);
        return -ENXIO;
    }

    switch (param.bar_type) {
    case 0:// BYTE
        param.bar_byte  = gowin_readb(data, param.bar_idx, param.bar_offset);
        break;
    case 1:// WORD
        param.bar_word  = gowin_readw(data, param.bar_idx, param.bar_offset);
        break;
    case 2:// DWORD
        param.bar_dword = gowin_readl(data, param.bar_idx, param.bar_offset);
        break;
    default:
        dev_dbg(dev, "What? (type=0x%d).\n", param.bar_type);
        return -EINVAL;
    }

    if (copy_to_user((void __user *)arg, &param, sizeof(param)))
        return -EFAULT;

    return 0;
}

/*!
 * ioctl_write_bar() -
 *      static function for iotcl: GOWIN_BAR_WRITE_DWORD
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_write_bar(
        struct gowin_bar_data *data, unsigned long arg)
{
    struct gowin_iotcl_param param;
    struct device *dev;

    if (WARN_ON(!data) || WARN_ON(!data->pdev) || WARN_ON(!arg))
        return -EINVAL;
    dev = &data->pdev->dev;

    if (copy_from_user(&param, (void __user *)arg, sizeof(param)))
        return -EFAULT;

    dev_dbg(dev, "Write BAR.\n");
    if (param.bar_idx >= PCI_STD_NUM_BARS)
        return -EINVAL;

    if (pci_resource_len(data->pdev, param.bar_idx) == 0) {
        dev_err(dev, "#%d BAR not available.\n", param.bar_idx);
        return -ENXIO;
    }

    switch (param.bar_type) {
    case 0:// BYTE
        gowin_writeb(data, param.bar_idx, param.bar_offset, param.bar_byte);
        break;
    case 1:// WORD
        gowin_writew(data, param.bar_idx, param.bar_offset, param.bar_word);
        break;
    case 2:// DWORD
        gowin_writel(data, param.bar_idx, param.bar_offset, param.bar_dword);
        break;
    default:
        dev_dbg(dev, "What? (type=0x%d).\n", param.bar_type);
        return -EINVAL;
    }
    return 0;
}

/*!
 * ioctl_read_config() -
 *      static function for iotcl: GOWIN_CONFIG_READ_DWORD
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_read_config(
        struct gowin_bar_data *data, unsigned long arg)
{
    struct gowin_iotcl_param param;
    struct device *dev;

    if (WARN_ON(!data) || WARN_ON(!data->pdev) || WARN_ON(!arg))
        return -EINVAL;
    dev = &data->pdev->dev;

    if (copy_from_user(&param, (void __user *)arg, sizeof(param)))
        return -EFAULT;

    switch (param.cfg_type) {
    case 0:// BYTE
        if (pci_read_config_byte(data->pdev,
                param.cfg_where, &param.cfg_byte))
            return -EFAULT;
        break;
    case 1:// WORD
        if (pci_read_config_word(data->pdev,
                param.cfg_where, &param.cfg_word))
            return -EFAULT;
        break;
    case 2:// DWORD
        if (pci_read_config_dword(data->pdev,
                param.cfg_where, &param.cfg_dword))
            return -EFAULT;
        break;
    default:
        dev_dbg(dev, "What? (type=0x%d).\n", param.cfg_type);
        return -EINVAL;
    }

    if (copy_to_user((void __user *)arg, &param, sizeof(param)))
        return -EFAULT;

    return 0;
}

/*!
 * ioctl_write_config() -
 *      static function for iotcl: GOWIN_CONFIG_WRITE_DWORD
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_write_config(
        struct gowin_bar_data *data, unsigned long arg)
{
    struct gowin_iotcl_param param;
    struct device *dev;

    if (WARN_ON(!data) || WARN_ON(!data->pdev) || WARN_ON(!arg))
        return -EINVAL;
    dev = &data->pdev->dev;

    if (copy_from_user(&param, (void __user *)arg, sizeof(param)))
        return -EFAULT;

    switch (param.cfg_type) {
    case 0:// BYTE
        if (pci_write_config_byte(data->pdev,param.cfg_where,param.cfg_byte))
            return -EFAULT;
        break;
    case 1:// WORD
        if (pci_write_config_word(data->pdev,param.cfg_where,param.cfg_word))
            return -EFAULT;
        break;
    case 2:// DWORD
        if (pci_write_config_dword(data->pdev,param.cfg_where,param.cfg_dword))
            return -EFAULT;
        break;
    default:
        dev_dbg(dev, "What? (type=0x%d).\n", param.cfg_type);
        return -EINVAL;
    }

    return 0;
}


/*!
 * ioctl_wait_irq() -
 *      static function for iotcl: GOWIN_WAIT_IRQ
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_wait_irq(
        struct gowin_bar_data *data, unsigned long arg)
{
    u64 count;
    int ret;
    u32 timeout;
    struct gowin_iotcl_param param;
    struct device *dev;

    if (WARN_ON(!data) || WARN_ON(!data->pdev) || WARN_ON(!arg))
        return -EINVAL;

    dev = &data->pdev->dev;

    if (copy_from_user(&param, (void __user *)arg, sizeof(param)))
        return -EFAULT;

    if (param.irq_idx < 0 || param.irq_idx >= GW_IRQ_NUM)
        return -EINVAL;

    timeout = param.timeout_ms;
    if (timeout == 0) {
        timeout = 1;
    }
    else if (timeout > 1000) {
        timeout = 1000;
    }

    count = atomic64_read(&data->irq_count[param.irq_idx]);
    do {
        ret = wait_event_interruptible_timeout(
                    data->irq_wait[param.irq_idx],
                    count != atomic64_read(&data->irq_count[param.irq_idx]),
                    msecs_to_jiffies(timeout));
        timeout = ret;
    } while (ret == -ERESTARTSYS);
    // printk(KERN_DEBUG "[ioctl_wait_irq] count[%d] = %lld (%lld, %d)\n", param.irq_idx, atomic64_read(&data->irq_count[param.irq_idx]), count, ret);
    // count = atomic64_read(&data->irq_count[param.irq_idx]);
    if (ret == 0) {
        return -ETIMEDOUT;
    } 
    return 0;
}

/*!
 * ioctl_dma_mem_request() -
 *      static function for iotcl: GOWIN_REQUEST_DMA_MEM
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_dma_mem_request(
        struct gowin_bar_data *data, unsigned long arg)
{
    int id, size;
    struct gowin_iotcl_param param;
    struct device *dev;

    // printk(KERN_DEBUG "ioctl_dma_mem_request() 1\n");
    if (WARN_ON(!data || WARN_ON(!data->pdev) || WARN_ON(!arg)))
        return -EINVAL;
    dev = &data->pdev->dev;

    if (copy_from_user(&param, (void __user *)arg, sizeof(param)))
        return -EFAULT;

    id = param.dma_idx;
    size = param.dma_size;
    if (id > MAX_DMA_CTX_NUM || size > SZ_4M) {
        dev_err(dev, "Wrong parameter.");
        return -EINVAL;
    }
    dev_dbg(dev, "DMA memory request. (%d)\n", id);

    if (param.dma_realloc == 0 && data->dma_ctx[id].len > 0) {
        dev_err(dev, "Memory has been requested.");
        return -EPERM;
    }

    if (param.dma_realloc != 0 && data->dma_ctx[id].len > 0) {
        // pci_free_consistent(data->pdev,
        dma_free_coherent(dev,
                          data->dma_ctx[id].len, 
                          data->dma_ctx[id].vir,
                          data->dma_ctx[id].phy);
        data->dma_ctx[id].len = 0;
        data->dma_ctx[id].vir = 0;
        data->dma_ctx[id].phy = 0;
    }
    // data->dma_ctx[id].vir = pci_alloc_consistent(data->pdev,
    //                                 size, &data->dma_ctx[id].phy);
    data->dma_ctx[id].vir = dma_alloc_coherent(dev, size, &data->dma_ctx[id].phy, GFP_KERNEL);
    if (data->dma_ctx[id].vir == NULL) {
        param.dma_handle = 0;
        dev_err(dev, "Failed to allocate DMA memory (%d).\n", id);
        return -ENOMEM;
    }
    ((char *)data->dma_ctx[id].vir)[0] = 0;
    data->dma_ctx[id].len = size;

    param.dma_handle = data->dma_ctx[id].phy;
    param.dma_addr = data->dma_ctx[id].vir;

    if (copy_to_user((void __user *)arg, &param, sizeof(param))) {
        // pci_free_consistent(data->pdev,
        dma_free_coherent(dev,
                            data->dma_ctx[id].len, 
                            data->dma_ctx[id].vir,
                            data->dma_ctx[id].phy);
        data->dma_ctx[id].len = 0;
        data->dma_ctx[id].vir = 0;
        data->dma_ctx[id].phy = 0;
        return -EFAULT;
    }
    else {
        dev_info(dev, "ioctl_dma_mem_request: vir:0x%pK, phy:0x%pK, len:%ld\n",
                data->dma_ctx[id].vir,
                (void *)data->dma_ctx[id].phy,
                data->dma_ctx[id].len);
    }

    return 0;
}

/*!
 * ioctl_dma_mem_release() -
 *      static function for iotcl: GOWIN_RELEASE_DMA_MEM
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_dma_mem_release(
        struct gowin_bar_data *data, unsigned long arg)
{
    int id;
    struct gowin_iotcl_param param;
    struct device *dev;

    // printk(KERN_DEBUG "ioctl_dma_mem_release() 1\n");
    if (WARN_ON(!data) || WARN_ON(!data->pdev) || WARN_ON(!arg))
        return -EINVAL;
    dev = &data->pdev->dev;

    if (copy_from_user(&param, (void __user *)arg, sizeof(param)))
        return -EFAULT;

    id = (int)param.dma_idx;
    if (id > MAX_DMA_CTX_NUM) {
        dev_err(dev, "Wrong parameter.");
        return -EINVAL;
    }

    if (id >= 0) {
        dev_info(dev, "#%d DMA memory released.\n", id);

        if (data->dma_ctx[id].len != 0) {
            // pci_free_consistent(data->pdev,
            dma_free_coherent(dev,
                                data->dma_ctx[id].len, 
                                data->dma_ctx[id].vir,
                                data->dma_ctx[id].phy);
            data->dma_ctx[id].len = 0;
            data->dma_ctx[id].vir = 0;
            data->dma_ctx[id].phy = 0;
        }
    }
    else {
        int i;

        dev_info(dev, "All DMA memory released.\n");

        for (i = 0; i < MAX_DMA_CTX_NUM; i++) {
            if (data->dma_ctx[i].len == 0)
                continue;
            // pci_free_consistent(data->pdev,
            dma_free_coherent(dev,
                                data->dma_ctx[i].len, 
                                data->dma_ctx[i].vir,
                                data->dma_ctx[i].phy);
            data->dma_ctx[i].len = 0;
            data->dma_ctx[i].vir = 0;
            data->dma_ctx[i].phy = 0;
        }
    }

    return 0;
}

/*!
 * ioctl_switch_bar_mem() -
 *      static function for iotcl: GOWIN_SWITCH_BAR_OR_MEM
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_switch_bar_mem(
        struct gowin_bar_data *data, unsigned long arg)
{
    int index;
    struct gowin_iotcl_param param;
    struct device *dev;

    if (WARN_ON(!data) || WARN_ON(!data->pdev) || WARN_ON(!arg))
        return -EINVAL;
    dev = &data->pdev->dev;

    if (copy_from_user(&param, (void __user *)arg, sizeof(param)))
        return -EFAULT;

    index = param.index;

    if (param.dma_select != 0) {
        if (index > MAX_DMA_CTX_NUM) {
            dev_err(dev, "Wrong parameter.");
            return -EINVAL;
        }
        data->cur_dma = index;
        data->mem_select = 1;
    }
    else {
        if (index > PCI_STD_NUM_BARS) {
            dev_err(dev, "Wrong parameter.");
            return -EINVAL;
        }
        if (pcim_iomap_table(data->pdev)[index] == NULL) {
            return -EINVAL;
        }
        data->cur_bar = index;
        // data->base = data->bar[index];
        data->mem_select = 0;
    }
    return 0;
}

/*!
 * ioctl_clear_irq_count() -
 *      static function for iotcl: GOWIN_GET_IRQ_COUNT
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_get_irq_count(
        struct gowin_bar_data *data, unsigned long arg)
{
    struct gowin_iotcl_param param;

    if (WARN_ON(!data) || WARN_ON(!data->pdev) || WARN_ON(!arg))
        return -EINVAL;
    
    if (copy_from_user(&param, (void __user *)arg, sizeof(param)))
        return -EFAULT;

    if (param.irq_idx < 0 || param.irq_idx >= GW_IRQ_NUM)
        return -EINVAL;

    param.irq_count = atomic64_read(&data->irq_count[param.irq_idx]);

    if (copy_to_user((void __user *)arg, &param, sizeof(param)))
        return -EFAULT;

    return 0;
}   

/*!
 * ioctl_clear_irq_count() -
 *      static function for iotcl: GOWIN_CLEAR_IRQ_COUNT
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_clear_irq_count(
        struct gowin_bar_data *data, unsigned long arg)
{
    if (WARN_ON(!data))
        return -EINVAL;
    if (arg < 0 || arg >= GW_IRQ_NUM)
        return -EINVAL;
    atomic64_set(&data->irq_count[arg], 0);
    return 0;
}  

/*!
 * ioctl_enable_irq() -
 *      static function for iotcl: GOWIN_IRQ_ENABLE
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_enable_irq(
        struct gowin_bar_data *data, unsigned long arg)
{
    u32 rval, mask;
    if (WARN_ON(!data))
        return -EINVAL;
    if (arg < 0 || arg >= GW_IRQ_NUM)
        return -EINVAL;

    mask = 1 << (arg < RDMA_CH_NUM ? arg : (arg - RDMA_CH_NUM + 16));
    gowin_writel(data, 0, 0x010, mask);
    rval = gowin_readl(data, 0, 0x008);
    gowin_writel(data, 0, 0x008, rval | mask);

    // enable_irq(pci_irq_vector(data->pdev, arg));

    return 0;
}

/*!
 * ioctl_disable_irq() -
 *      static function for iotcl: GOWIN_IRQ_DISABLE
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_disable_irq(
        struct gowin_bar_data *data, unsigned long arg)
{
    u32 rval, mask;
    if (WARN_ON(!data))
        return -EINVAL;
    if (arg < 0 || arg >= GW_IRQ_NUM)
        return -EINVAL;

    // disable_irq(pci_irq_vector(data->pdev, arg));

    mask = 1 << (arg < RDMA_CH_NUM ? arg : (arg - RDMA_CH_NUM + 16));
    rval = gowin_readl(data, 0, 0x008);
    gowin_writel(data, 0, 0x008, rval & ~mask);

    return 0;
}

/*!
 * ioctl_thoughtput_test() -
 *      static function for iotcl: GOWIN_THROUGHPUT_TEST
 *      Only for test.
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_thoughtput_test(
        struct gowin_bar_data *data, unsigned long arg)
{
#if 0
    int ret;
    struct gowin_iotcl_param param;
    struct device *dev;

    if (WARN_ON(!data) || WARN_ON(!data->pdev) || WARN_ON(!arg))
        return -EINVAL;

    dev = &data->pdev->dev;

    if (copy_from_user(&param, (void __user *)arg, sizeof(param)))
        return -EFAULT;

    ioctl_enable_irq(data, 0);
    data->test = &param;
    do {
        if (param.dma_number == 0)  break;
        gowin_writel(data, 0, 0x100, param.dma_addr_lo);
        gowin_writel(data, 0, 0x104, param.dma_addr_hi);
        gowin_writel(data, 0, 0x110, param.dma_length);
        gowin_writel(data, 0, 0x114, 0x55);     //! triggr
        ret = wait_event_interruptible(data->irq_wait[0], param.dma_number == 0);
    } while (0);
    data->test = NULL;
    ioctl_disable_irq(data, 0);

    return ret;
#else
    return 0;
#endif
}   

/*!
 * ioctl_debug() -
 *      static function for iotcl: GOWIN_DEBUG_ONLY
 * 
 * @param[in]   data:   pointer to struct gowin_bar_data
 * @param[inout] arg:   parameters for iotcl
 */
static int ioctl_debug(
        struct gowin_bar_data *data, unsigned long arg)
{
    if (WARN_ON(!data))
        return -EINVAL;

    if (data->mem_select != 0) {
        struct dma_context *ctx = data->dma_ctx;
        int i = data->cur_dma;
        char * p = ctx[i].vir;
        if (p) {
            dev_info(&data->pdev->dev,
                    "ioctl_debug: \"%s\"\n", p);
        }
    }
    return 0;
}   

static long gowin_bar_ioctl(struct file *filp,
            unsigned int cmd, unsigned long arg)
{
    struct device *dev;
    struct gowin_bar_data *data = filp->private_data;
    int err = 0;

    if (WARN_ON(!data) || WARN_ON(!data->pdev))
        return -EINVAL;
    dev = &data->pdev->dev;

    mutex_lock(&data->mutex);

    switch (cmd) {
    case GOWIN_BAR_READ_DWORD:
        err = ioctl_read_bar(data, arg);
        break;
    case GOWIN_BAR_WRITE_DWORD:
        err = ioctl_write_bar(data, arg);
        break;
    case GOWIN_CONFIG_READ_DWORD:
        err = ioctl_read_config(data, arg);
        break;
    case GOWIN_CONFIG_WRITE_DWORD:
        err = ioctl_write_config(data, arg);
        break;
    case GOWIN_WAIT_IRQ:
        err = ioctl_wait_irq(data, arg);
        break;
    case GOWIN_REQUEST_DMA_MEM:
        err = ioctl_dma_mem_request(data, arg);
        break;
    case GOWIN_RELEASE_DMA_MEM:
        err = ioctl_dma_mem_release(data, arg);
        break;
    case GOWIN_SWITCH_BAR_OR_MEM:
        err = ioctl_switch_bar_mem(data, arg);
        break;
    case GOWIN_GET_IRQ_COUNT:
        err = ioctl_get_irq_count(data, arg);
        break;
    case GOWIN_CLEAR_IRQ_COUNT:
        err = ioctl_clear_irq_count(data, arg);
        break;
    case GOWIN_IRQ_ENABLE:
        err = ioctl_enable_irq(data, arg);
        break;
    case GOWIN_IRQ_DISABLE:
        err = ioctl_disable_irq(data, arg);
        break;
    case GOWIN_THROUGHPUT_TEST:
        err = ioctl_thoughtput_test(data, arg);
        break;
    case GOWIN_DEBUG_ONLY:
        err = ioctl_debug(data, arg);
        break;
    default:
        dev_dbg(dev, "What? (cmd=0x%x).\n", cmd);
        err = -EINVAL;
    }

    mutex_unlock(&data->mutex);

    return err;
}

static int gowin_bar_open(struct inode *inode, struct file *filp)
{
    int err;
    unsigned long flags;
    struct device *dev;
    struct cdev *cdev = inode->i_cdev;
    struct gowin_bar_data *data = container_of(cdev, 
                        struct gowin_bar_data, gw_cdev);
    if (WARN_ON(!data) || WARN_ON(!data->pdev)) {
        return -ENODEV;
    }
    dev = &data->pdev->dev;

    spin_lock_irqsave(&data->lock, flags);
    if (data->open_cnt) {
        dev_warn(dev, " busy.\n");
        err = -EBUSY;
    }
    else {
        dev_dbg(dev, "gowin_bar_open() DEBUG.\n");
        err = 0;
        data->open_cnt++;
    }
    spin_unlock_irqrestore(&data->lock, flags);

    filp->private_data = data;

    return err;
}

/*!
 * gowin_bar_mmap() -
 *      static inline function that maps the PCIe BAR int user space for
 * memory-like access using mma()
 * 
 */
static int gowin_bar_mmap(struct file *filp, struct vm_area_struct *vma)
{
    int ret;
    struct device *dev;
    struct gowin_bar_data *data = filp->private_data;
    void          *vir; 
    unsigned long off;
    unsigned long phys;
    unsigned long vsize;
    unsigned long psize;

    // printk(KERN_DEBUG "vm_start: 0x%lx; vm_end:0x%lx\n", vma->vm_start, vma->vm_end);
    // printk(KERN_DEBUG "vm_flags: 0x%lx\n", vma->vm_flags);
    // return 0;

    if (WARN_ON(!data) || WARN_ON(!data->pdev)) {
        return -ENODEV;
    }
    dev = &data->pdev->dev;

    off = vma->vm_pgoff << PAGE_SHIFT;
    vsize = vma->vm_end - vma->vm_start;

    if (data->mem_select == 0) {
        /*! resource length*/
        psize = pci_resource_len(data->pdev, data->cur_bar);
        if (psize == 0) {
            dev_err(dev, "BAR #%d not available.\n", data->cur_bar);
            return -ENXIO;
        }
        /*! BAR physical address*/
        phys = pci_resource_start(data->pdev, data->cur_bar) + off;
        if (pci_resource_end(data->pdev, data->cur_bar) < phys) {
            // printk(KERN_DEBUG "DEBUG 1-1\n");
            return -EINVAL;
        }
    }
    else {
        // printk(KERN_DEBUG "gowin_bar_mmap() DEBUG 2\n");
        vir   = data->dma_ctx[data->cur_dma].vir + off;
        phys  = (unsigned long)data->dma_ctx[data->cur_dma].phy + off;
        psize = (unsigned long)data->dma_ctx[data->cur_dma].len - off;
    }

    printk(KERN_DEBUG "vma->vm_pgoff:%ld, vsize: %ld, psize:%ld\n",vma->vm_pgoff, vsize, psize);
    if (vsize > psize || psize <= 0) {
        return -EINVAL;
    }

    /*!
     *  page must not be cached as this would result in cache line size
     *  accesses to the end point
     */
    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
    /*!
     * prevent touching the pages (byte access) for swap-in,
     * and prevent the pages from being swapped out
     */
    vma->vm_flags |= VMEM_FLAGS;
    if (data->mem_select == 0) {
        /*! make MMIO accessible to user space */
        //! TODO
        ret = io_remap_pfn_range(vma, vma->vm_start,
                    phys >> PAGE_SHIFT, vsize, vma->vm_page_prot);
    }
    else {
        // set_memory_uc(vir, vsize / PAGE_SIZE);
        ret = remap_pfn_range(vma, vma->vm_start,
                    phys >> PAGE_SHIFT, vsize, vma->vm_page_prot);
    }
    if (ret)
        return -EAGAIN;

    dev_dbg(dev, "vma=0x%p, vma->vm_start=0x%lx, phys=0x%lx, size=%lu\n",
            vma, vma->vm_start, phys >> PAGE_SHIFT, vsize);

    return 0;
}

static int gowin_bar_release(struct inode *inode, struct file *filp)
{
    unsigned long flags;
    struct device *dev;
    struct gowin_bar_data *data = filp->private_data;

    if (WARN_ON(!data) || WARN_ON(!data->pdev)) {
        return -ENODEV;
    }
    dev = &data->pdev->dev;

    dev_dbg(dev, "gowin_bar_release() DEBUG.\n");

    spin_lock_irqsave(&data->lock, flags);
    data->open_cnt--;
    spin_unlock_irqrestore(&data->lock, flags);

    return 0;
}

static const struct file_operations gowin_bar_fops = {
    .owner          = THIS_MODULE,
    .unlocked_ioctl = gowin_bar_ioctl,
    .compat_ioctl   = compat_ptr_ioctl,
    .llseek         = no_llseek,
    .open           = gowin_bar_open,
    //.write          = ,
    .mmap           = gowin_bar_mmap,
    .release        = gowin_bar_release,
};

static int gowin_bar_probe(struct pci_dev *pdev,
    const struct pci_device_id *did)
{
    int i;
    int err;
    int irq;
    int bar;
    struct gowin_bar_data *data;
    struct device *dev = &pdev->dev;

    if (drvOccupied)
        return -EBUSY;

    drvOccupied = 1;

    if (pci_is_bridge(pdev))
        return -ENODEV;

    dev_info(dev, DRIVER_NAME " probe (0x%04x/0x%04x)",
            pdev->vendor, pdev->device);

    data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);

    if (!data)
        return -ENOMEM;

    data->pdev = pdev;

    err = pcim_enable_device(pdev);

    if (unlikely(err)) {
        dev_err(dev, "Cannot enable PCI device.\n");
        return err;
    }

    pci_set_master(pdev);

    // if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
    //     if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32))) {
    //         dev_err(dev, "No suitable DMA available.\n");
    //         return -EINVAL;
    //     }
    //     else {
    //         dev_info(dev, "Use 32-bits DMA\n");
    //         pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
    //     }
    // }
    // else {
    //     dev_info(dev, "Use 64-bits DMA\n");
    //     pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
    // }
    if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))) {
        if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))) {
            dev_err(dev, "No suitable DMA available.\n");
            return -EINVAL;
        }
        else {
            dev_info(dev, "Use 32-bits DMA\n");
        }
    }
    else {
        dev_info(dev, "Use 64-bits DMA\n");
    }

#if 1
    err = pcim_iomap_regions_request_all(pdev, 1, DRIVER_NAME);
    if (unlikely(err)) {
        dev_err(dev, "pcim_iomap_regions_request_all() failed. (%d)\n", err);
        return err;
    }
    data->cur_bar = -1;
    for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
        if (!pcim_iomap_table(pdev)[bar])
            continue;
        if (data->cur_bar < 0)
            data->cur_bar = bar;
    }
    if (data->cur_bar < 0) {
        dev_err(dev, "No BAR available.\n");
        return -ENOMEM;
    }

    // irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
    irq = pci_alloc_irq_vectors(pdev, GW_IRQ_NUM, GW_IRQ_NUM, PCI_IRQ_MSI);
    if (irq < 0) {
        irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
        if (irq < 0) {
            dev_err(dev, "pci_alloc_irq_vectors failed. (errno: %d)\n", irq);
            return -EINVAL;
        }
        dev_err(dev, "Use single interrupt mode.\n");
        msi_number = 1;
    }
    else {
        msi_number = GW_IRQ_NUM;
    }

    gowin_writel(data, 0, 0x0010, 0xFFFFFFFF);

    for (i = 0; i < GW_IRQ_NUM; i++) {
        if (msi_number > 1 || i == 0) {
            err = pci_request_irq(pdev, i, gowin_bar_irq_handler, 0, data, DRIVER_NAME);
            if (unlikely(err)) {
                break;
            }
            data->irq_number[i] = pci_irq_vector(pdev, i);
            // disable_irq(data->irq_number[i]);
        }
        else {
            data->irq_number[i] = pci_irq_vector(pdev, 0);
        }
    }

    if (unlikely(i < GW_IRQ_NUM)) {
        if (msi_number == 1) {
            pci_free_irq(pdev, 0, data);
        }
        else {
            for (; i >= 0; i--) {
                pci_free_irq(pdev, i, data);
            }
        }
        goto err_free_irq_vectors;
    }

#endif

    err = alloc_chrdev_region(&data->gw_devid, 0, 1, DRIVER_NAME);
    if (err < 0) {
        dev_err(dev, "alloc_chrdev_region() failed.\n");
        err = -EINVAL;
        goto err_free_pci_irq;
    }

    data->gw_cdev.owner = THIS_MODULE;
    cdev_init(&data->gw_cdev, &gowin_bar_fops);
    err = cdev_add(&data->gw_cdev, data->gw_devid, 1);
    if (err) {
        dev_err(dev, "cdev_add() failed.\n");
        goto err_unregister_chrdev_region;
    }

    data->gw_class = class_create(THIS_MODULE, CLASS_NAME);

    if (IS_ERR(data->gw_class)) {
        dev_err(dev, "class_create() failed.\n");
        err = -EINVAL;
        goto err_cdev_del;
    }

    data->gw_device = device_create(data->gw_class,
                        NULL, data->gw_devid, NULL, DRIVER_NAME);

    if (IS_ERR(data->gw_device)) {
        dev_err(dev, "device_create() failed.\n");
        err = -EINVAL;
        goto err_class_destroy;
    }

    // for (i = 0; i < msi_number; i++) {
    for (i = 0; i < GW_IRQ_NUM; i++) {
        atomic64_set(&data->irq_count[i], 0);
        init_waitqueue_head(&data->irq_wait[i]);
    }

    do {
        u32 rval = 0;
        for (i = 0; i < RDMA_CH_NUM; i++) {
            rval |= 1 << i;
        }
        for (i = 0; i < WDMA_CH_NUM; i++) {
            rval |= 1 << (i+16);
        }
        gowin_writel(data, 0, 0x0008, 0);   // mask all IRQ
        gowin_writel(data, 0, 0x010, rval); // clear all IRQ
        if (msi_number > 1) { //Set IRQ auto-clear if not single IRQ mode
            gowin_writel(data, 0, 0x00C, rval);
        }
        else {
            gowin_writel(data, 0, 0x00C, 0);
        }
        gowin_writel(data, 0, 0x0004, rval);// enable all channel
        rval = (msi_number > 1) ? 1 : 3;    // single IRQ mode ?
        gowin_writel(data, 0, 0x0000, rval);// enable device
    } while(0);


    spin_lock_init(&data->lock);
    pci_set_drvdata(pdev, data);

    /*! try set maximum memory read request to 4096 */
    pcie_set_readrq(pdev, 4096);

    return 0;

err_class_destroy:
    class_destroy(data->gw_class);
err_cdev_del:
    cdev_del(&data->gw_cdev);
err_unregister_chrdev_region:
    unregister_chrdev_region(data->gw_devid, 1);
err_free_pci_irq:
    pci_free_irq(pdev, 0, data);
    for (i = 0; i < msi_number; i++) {
        pci_free_irq(pdev, i, data);
    }
err_free_irq_vectors:
    pci_free_irq_vectors(pdev);

    dev_err(dev, "Failed to register device (errno:%d).\n", err);

    msi_number  = 0;
    drvOccupied = 0;
	return err;
}

static void gowin_bar_remove(struct pci_dev *pdev)
{
    int i;
    struct gowin_bar_data *data = pci_get_drvdata(pdev);

    dev_info(&pdev->dev, DRIVER_NAME " remove");

    if (data) {
        device_destroy(data->gw_class, data->gw_devid);
        class_destroy(data->gw_class);
        cdev_del(&data->gw_cdev);
        unregister_chrdev_region(data->gw_devid, 1);

        for (i = 0; i < msi_number; i++) {
            pci_free_irq(pdev, i, data);
        }
        pci_free_irq_vectors(pdev);

        if (msi_number > 1) { //clear IRQ auto-clear
            gowin_writel(data, 0, 0x00C, 0);
        }
    }
    msi_number  = 0;
    drvOccupied = 0;
}

static const struct pci_device_id gowin_tbl[] = {
    { PCI_DEVICE(0x22c2, 0x1100),
    // { PCI_DEVICE(PCI_ANY_ID, PCI_ANY_ID),
    //   .driver_data = (kernel_ulong_t)&default_data,
    },
    {0}
};

MODULE_DEVICE_TABLE(pci, gowin_tbl);

static struct pci_driver gowin_bar_driver = {
    .name       = DRIVER_NAME,
    .id_table   = gowin_tbl,
    .probe      = gowin_bar_probe,
    .remove     = gowin_bar_remove,
};

module_pci_driver(gowin_bar_driver)

MODULE_DESCRIPTION("GoWin-PCIe BAR Ctrl Driver");
MODULE_AUTHOR("Huang Mingtao <mingtao@gowinsemi.com>");
MODULE_LICENSE("GPL");
MODULE_VERSION(DRIVER_VERSION);
