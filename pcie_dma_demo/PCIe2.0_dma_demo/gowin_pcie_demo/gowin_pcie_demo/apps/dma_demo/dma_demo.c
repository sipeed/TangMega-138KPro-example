
#include <stdint.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>

#include <fcntl.h>
// #include <sys/types.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <arpa/inet.h>

#include "../../include/gowin_pcie_bar_drv_uapi.h"
#include "../libs/gowin_utils.h"

#define DMA_SIZE    (1024 * 1024)
#define BAR_SIZE    (1024 * 4)

int DBG_INFO = 0;

typedef struct __gowin_bar {
    volatile uint32_t    ctrl;          //! 0x0000 - global enable
    volatile uint32_t    chsw;          //! 0x0004 - channel enable
    volatile uint32_t    intr;          //! 0x0008 - irq enabel
    volatile uint32_t    aclr;          //! 0x000C - auto irq clear
    volatile uint32_t    ista;          //! 0x0010 - irq status and clear
    volatile uint32_t    rsv1[3];       //! 0x0010 - irq status and clear
    volatile uint32_t    devctrl;
    volatile uint32_t    rsv2[55];

    struct {
        volatile uint32_t    rdma_src_lo;   //! 0x0100 - lower address of system memory
        volatile uint32_t    rdma_src_hi;   //! 0x0104 - upper address of system memory
        volatile uint32_t    rdma_len;      //! 0x0108 - length for RDMA
        volatile uint32_t    rdma_tag;      //! 0x010C - reference TAG for RDMA
        volatile uint32_t    rdma_it_level; //! 0x0110 - RDMA irq trigger level
        volatile uint32_t    rdma_status;   //! 0x0114 - current RDMA queue level (RO)
        volatile uint32_t    rdma_rsv[58];  //!

        volatile uint32_t    wdma_dst_lo;   //! 0x0200 - lower address of system memory
        volatile uint32_t    wdma_dst_hi;   //! 0x0204 - upper address of system memory
        volatile uint32_t    wdma_len;      //! 0x0208 - length for WDMA
        volatile uint32_t    wdma_tag;      //! 0x020C - reference TAG for RDMA
        volatile uint32_t    wdma_it_level; //! 0x0210 - WDMA irq trigger level
        volatile uint32_t    wdma_status;   //! 0x0214 - current WDMA queue level (RO)
        volatile uint32_t    wdma_rsv[58];  //!
    } channel[8];
} GowinBar;

int add_mode[8] = {3, 1, 0, 1, 0, 1, 0, 1};

static inline int64_t get_clock()
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec*1000000000ll+ts.tv_nsec;
}

static int to_count = 0;
void wait_irq(int fd, int irq_num, int ms)
{
    struct gowin_iotcl_param param;
    param.irq_idx = irq_num;
    param.timeout_ms = ms;

    int ret = ioctl(fd, GOWIN_WAIT_IRQ, &param);
    if (ret) {
        to_count++;
        if (DBG_INFO) fprintf(stderr, "ioctl failed. %s\n", strerror(errno));
    }
}

int main(int argc, char *argv[])
{
    volatile int val;
    int64_t t1, t2;
    int mode = 1;
    int cnt  = 32;
    int cnt_align = 32;
    int loop = 1;
    int dump = 0;
    struct gowin_iotcl_param param = {0,};

    if (argc > 1) {
        if (!strcmp(argv[1], "both") || !strcmp(argv[1], "b") || !strcmp(argv[1], "loop")) {
            mode = 3;
        }
        else if (!strcmp(argv[1], "c2h") || !strcmp(argv[1], "r") || !strcmp(argv[1], "rx")) {
            mode = 2;
        }
    }
    if (argc > 2) {
        cnt = strtol(argv[2], NULL, 0);
        if (cnt <= 0) cnt = 32;
        cnt_align = (cnt + 255) & ~255;
    }
    if (argc > 3) {
        loop = strtol(argv[3], NULL, 0);
        if (mode == 3 && loop < 4) loop = 4;
        else if (loop <= 0) loop = 1;
    }
    if (argc > 4) {
        if (!strcmp(argv[4], "dump")) dump = 1;
    }

    uint64_t dma_src = 0;
    uint8_t *mem_src = NULL;

    uint64_t dma_dst = 0;
    uint8_t *mem_dst = NULL;

    uint32_t *bar = NULL;
    GowinBar *gwbar = NULL;
    int ret;

    int fd = dev_open(NULL);

    if (fd < 0) {
        fprintf(stderr, "Failed to open the device (%s)\n", strerror(errno));
        return -1;
    }
    float bandwidth = 2.0f;
    do {
        param.cfg_type = 2;
        param.cfg_where = 0x90;
        val = ioctl(fd, GOWIN_CONFIG_READ_DWORD, &param);
        if (val) {
            break;
        }
        else {
            switch ((param.cfg_dword >> 16) & 0xF)
            {
            case 2: bandwidth = 4.0f;
                break;
            case 3: bandwidth = 7.877f;
                break;
            default: bandwidth = 2.0f;
                break;
            }
            bandwidth *= (param.cfg_dword >> 20) & 0x3F;
            // fprintf(stdout, "******** bandwidth %0.3f ********\n", bandwidth);
        }

        dma_src = request_mem(fd, 0, DMA_SIZE);
        if (!dma_src) {
            break;
        }
        mem_src = mmap_mem(fd, 0, DMA_SIZE);
        if (!mem_src) {
            break;
        }
        dma_dst = request_mem(fd, 1, DMA_SIZE);
        if (!dma_dst) {
            break;
        }
        mem_dst = mmap_mem(fd, 1, DMA_SIZE);
        if (!mem_dst) {
            break;
        }

        bar = mmap_bar(fd, 0, BAR_SIZE);
        if (!bar) {
            break;
        }
        gwbar = (GowinBar *)bar;

        param.cfg_type = 2;
        param.cfg_where = 0x88;
        while (1) {
            if (!ioctl(fd, GOWIN_CONFIG_READ_DWORD, &param) && param.cfg_dword != 0xFFFFFFFF) {
                //val = (param.cfg_dword & 0xFF1F);            // Maxpayload: 128
                val = (param.cfg_dword & 0xFF1F) | (1<<5);   // Maxpayload: 256
                // val = (param.cfg_dword & 0xFF1F) | (2<<5);   // Maxpayload: 512
                // val = (param.cfg_dword & 0xFF1F) | (3<<5);   // Maxpayload: 1024
                fprintf(stdout, "******** devctrl: %04x ********\n", val);
                gwbar->devctrl = val;   // Maxpayload: 512
                break;
            }
        }

        uint8_t rx_tag = 16;
        uint8_t tx_tag = 16;
        volatile uint8_t  *sp = mem_src;
        volatile uint64_t  sa = dma_src;

        volatile uint8_t  *dp = mem_dst;
        volatile uint64_t  da = dma_dst;

        for (int i = 0 ; i < DMA_SIZE/2; i++) {
            *(uint16_t *)(&sp[i*2]) = i%65536;
        }
        int block_size = (cnt * 4 + 1023) & (~1023);
        // sp += 1024;
        // sa += 1024;

        if (DBG_INFO) fprintf(stdout, "******** block_size %d ********\n", block_size);

        ioctl(fd, GOWIN_IRQ_ENABLE, 0);
        ioctl(fd, GOWIN_IRQ_ENABLE, 1);

        // bar_writel(fd, 0, 0x04, (3 << 16) | 3);
        // gwbar->chsw = (3 << 16) | 3;
        // bar_writel(fd, 0, 0x08, (3 << 16) | 3);
        gwbar->intr = (mode == 1) ? 1 : (1 << 16);
	    //gwbar->intr = 0x00010001;


        // gwbar->aclr = (3 << 16) | 3;

        if (DBG_INFO) fprintf(stdout, "chack DMA enable: 0x%08x\n", gwbar->ctrl);
        if (DBG_INFO) fprintf(stdout, "enable DMA\n");
        val = gwbar->ctrl;
        val |= 1;
        gwbar->ctrl = val;
        // gwbar->intr = 3;
        if (DBG_INFO) fprintf(stdout, "chack DMA enable: 0x%08x\n", gwbar->ctrl);

        gwbar->channel[0].rdma_it_level = 16;
        gwbar->channel[0].wdma_it_level = 16;

	    t1 = get_clock();
        int i = 0;
        int j = 0;
        int c2h_count = (mode & 2) ? 0 : loop + 1;
        int h2c_count = (mode & 1) ? 0 : loop + 1;

        // fprintf(stdout, "c2h_count=%d, h2c_count=%d\n", c2h_count, h2c_count);

        int ni = (loop + 15) / 16;
        int no = (loop + 15) / 16;
        volatile int h2c_level = 0;
        volatile int c2h_level = 0;
        while(c2h_count < loop || h2c_count < loop) {
            if (DBG_INFO) fprintf(stdout, "******** Loop %d ********\n", j);

            if (mode & 1) { // h2c
                if (dump && h2c_count == 0) {
                    fprintf(stdout, "Dump data @0x%p before copy to card:\n", sp);
                    for (int i = 0; i < cnt*4; i++) {
                        if (i%16 == 0) fprintf(stdout, "0x%08x: ", i);
                        fprintf(stdout, "0x%02x ", sp[i]);
                        if (i % 16 == 15 || i == cnt*4 -1) fprintf(stdout, "\n");
                    }
                }

                if (DBG_INFO) fprintf(stdout, "start copy to card\n");
                j = (h2c_count == 0) ? 16 : (h2c_level < 64 ? 32 : 0);
                while (h2c_count < loop && j > 0) {
                    gwbar->channel[0].rdma_src_lo = sa & 0xFFFFFFFC;
                    gwbar->channel[0].rdma_src_hi = (sa >> 32) & 0xFFFFFFFF;
                    gwbar->channel[0].rdma_len = cnt;                    //! length 0x20(32) * 4 = 128B
                    gwbar->channel[0].rdma_tag = rx_tag++;
                    if (rx_tag >= 32) rx_tag = 1;
                    j--;
                    h2c_count++;

                    sa += block_size;
                    sp += block_size;
                    if (sa + block_size > dma_src + DMA_SIZE) {
                        sp = mem_src;
                        sa = dma_src;
                    }
                }
                do {
                    h2c_level = gwbar->channel[0].rdma_status & 0xFF;
                } while(255 == h2c_level);

                if (!(mode & 2)) {
                    // i = 0;
                    if (h2c_level > 64) {
                        // wait_irq(fd, 0, 1);
                        // fprintf(stdout, "# %d (%d)\n", h2c_level, h2c_count);
                    }

                    if (h2c_count == loop) {    //! only RDMA
                        do {
                            // val = bar_readl(fd, 0, 0x0114);
                            val = 0xC0000000 & gwbar->channel[0].rdma_status;
                            // fprintf(stdout, "val:%d (0x%08x)\n", val, val);
                        } while (val != 0xC0000000);
                    }
                    else {
                        do {
                            h2c_level = gwbar->channel[0].rdma_status & 0xFF;
                        } while(255 == h2c_level);
                    }
                }
            }

            if (mode & 2) { //c2h
                if (DBG_INFO) fprintf(stdout, "---------------------------\nstart copy to host\n");
                j = (c2h_count == 0) ? 8 : (c2h_level < 64 ? 32 : 0);
                while (c2h_count < loop && j > 0) {
                    gwbar->channel[0].wdma_dst_lo = da & 0xFFFFFFFF;
                    gwbar->channel[0].wdma_dst_hi = (da >> 32) & 0xFFFFFFFF;
                    gwbar->channel[0].wdma_len = cnt;                    //! length 32 * 4 = 128B
                    gwbar->channel[0].wdma_tag = tx_tag++;
                    if (tx_tag >= 32) tx_tag = 16;
                    j--;
                    c2h_count++;

                    da += block_size;
                    dp += block_size;
                    if (da + block_size > dma_dst + DMA_SIZE) {
                        dp = mem_dst;
                        da = dma_dst;
                    }
                }
                do {
                    c2h_level = gwbar->channel[0].wdma_status & 0xFF;
                    // val = bar_readl(fd, 0, 0x0214) & 0xFF;
                    // fprintf(stdout, ".... %x(%d)\n", val, val);
                    // if (val & 0xff > 16) val = -1;
                }  while(255 == c2h_level);
                if (1) {
                    if (c2h_level > 32) {
                        // fprintf(stdout, "before wait_irq\n");
                        // wait_irq(fd, 1, 1);
                        // fprintf(stdout, "after wait_irq\n");
                    }
                    if (c2h_count == loop) { 
                        do {
                            // val = bar_readl(fd, 0, 0x0214);
                            // val &= 0xC0000000;
                            val = 0xC0000000 & gwbar->channel[0].wdma_status;
                        } while (val != 0xC0000000);
                        if (dump) {
                            fprintf(stdout, "Dump data @0x%p after copy to host:\n", dp);
                            for (int i = 0; i < cnt*4; i++) {
                                if (i%16 == 0) fprintf(stdout, "0x%08x: ", i);
                                fprintf(stdout, "0x%02x ", dp[i]);
                                if (i % 16 == 15 || i == cnt*4 - 1) fprintf(stdout, "\n");
                            }
                        }
                    }
                }
            }

            // if (mode == 3) {
            //     int i;
            //     for (i = 0; i < cnt*4; i++) {
            //         if (sp[i] != (~dp[i] & 0xFF)) break;
            //     }
            //     if (i < cnt*4) {
            //         if (DBG_INFO) fprintf(stdout, "differ at offset %d: \033[31m0x%02x != ~0x%02x\033[0m \n", i, sp[i], ~dp[i]);
            //     }
            // }
        }

	    t2 = get_clock();
        t2 -= t1;
        uint64_t total = (uint64_t)loop * cnt * 4;
        float bps = total * 8.0f / t2;
        float rate = bps * 100.f / bandwidth;

        fprintf(stdout, "\nTotal data: %ld bytes. \nTime elapsed: %ld ns.\n", total, t2);
        fprintf(stdout, "Speed: %2.3f Gbps (%2.1f%%)\n", bps, rate);

       ioctl(fd, GOWIN_IRQ_DISABLE, 1);
       ioctl(fd, GOWIN_IRQ_DISABLE, 0);
        // bar_writel(fd, 0, 0x08, 3 << 16);
    } while(0);

    fprintf(stdout, "timeout count: %d\n", to_count);

    if (bar) {
        munmap(bar, BAR_SIZE);
    }
    if (mem_dst) {
        munmap(mem_dst, DMA_SIZE);
    }
    if (dma_dst) {
        release_mem(fd, 1);
    }
    if (mem_src) {
        munmap(mem_src, DMA_SIZE);
    }
    if (dma_src) {
        release_mem(fd, 0);
    }
    

	return 0;
}
