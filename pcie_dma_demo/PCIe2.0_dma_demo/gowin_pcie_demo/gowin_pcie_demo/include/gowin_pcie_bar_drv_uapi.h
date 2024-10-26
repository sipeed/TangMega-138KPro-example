// ===========Oooo==========================================Oooo========
// =  Copyright (C) 2014 Shanghai Gowin Semiconductor Technology Co.,Ltd.
// =                     All rights reserved.
// =====================================================================
//
//  __      __      __
//  \ \    /  \    / /   [File name   ] gowin_pcie_drv.h
//   \ \  / /\ \  / /    [Description ] Header file for PCIE demo driver
//    \ \/ /  \ \/ /     [Timestamp   ] 2022/11/22
//     \  /    \  /      [version     ] 1.0
//      \/      \/       
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Ver: | Author        | Mod. Date  | Changes Made:
// V1.0 | Huang Mingtao | 2022/11/22 | Initial version
// ===========Oooo==========================================Oooo========

#ifndef __GOWIN_PCIE_BAR_DRV_UAPI_H
#define __GOWIN_PCIE_BAR_DRV_UAPI_H

#define RDMA_CH_NUM         1
#define WDMA_CH_NUM         1

#define GOWIN_BAR_READ_DWORD        _IOWR('G',  0x1, unsigned long)
#define GOWIN_BAR_WRITE_DWORD       _IOWR('G',  0x2, unsigned long)
#define GOWIN_CONFIG_READ_DWORD     _IOWR('G',  0x3, unsigned long)
#define GOWIN_CONFIG_WRITE_DWORD    _IOWR('G',  0x4, unsigned long)
#define GOWIN_SWITCH_BAR_OR_MEM     _IOW ('G',  0x5, unsigned long)
#define GOWIN_REQUEST_DMA_MEM       _IOWR('G',  0x6, unsigned long)
#define GOWIN_RELEASE_DMA_MEM       _IOW ('G',  0x7, unsigned long)
#define GOWIN_WAIT_IRQ              _IOW ('G',  0x8, unsigned long)
#define GOWIN_GET_IRQ_COUNT         _IOWR('G',  0x9, unsigned long)
#define GOWIN_CLEAR_IRQ_COUNT       _IOW ('G',  0xA, unsigned long)
#define GOWIN_IRQ_ENABLE            _IOW ('G',  0xB, unsigned long)
#define GOWIN_IRQ_DISABLE           _IOW ('G',  0xC, unsigned long)
#define GOWIN_THROUGHPUT_TEST       _IOW ('G', 0x1E, unsigned long)
#define GOWIN_DEBUG_ONLY            _IOWR('G', 0x1F, unsigned long)

struct gowin_iotcl_param {
    union {
        uint32_t argv[8];
        struct {
            int32_t     bar_idx;
            uint32_t    bar_type;
            uint32_t    bar_offset;
            union {
                uint32_t    bar_dword;
                uint16_t    bar_word;
                uint8_t     bar_byte;
            };
        };
        struct {
            uint32_t    cfg_type;
            uint32_t    cfg_where;
            union {
                uint32_t    cfg_dword;
                uint16_t    cfg_word;
                uint8_t     cfg_byte;
            };
        };
        struct {
            int32_t     dma_idx;
            uint32_t    dma_size;
            uint32_t    dma_realloc;
            uint32_t    nu_2;
            void       *dma_addr;
            uint64_t    dma_handle;
        };
        struct {
            int32_t     index;
            uint32_t    dma_select;
        };
        struct {
            int32_t     irq_idx;
            uint32_t    timeout_ms;
        };
        struct {
            int64_t     irq_count;
        };
        struct {
            uint32_t    dma_addr_hi;
            uint32_t    dma_addr_lo;
            uint32_t    dma_length;
            uint32_t    dma_number;
        };
    };
};

#endif //! __GOWIN_PCIE_BAR_DRV_UAPI_H