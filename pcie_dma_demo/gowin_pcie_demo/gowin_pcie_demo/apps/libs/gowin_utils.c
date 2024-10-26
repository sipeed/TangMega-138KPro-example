#include <stdint.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>

#include <fcntl.h>

#include <sys/ioctl.h>
#include <sys/mman.h>

#include "../../include/gowin_pcie_bar_drv_uapi.h"

const char driver_node[] = "/dev/gowin_pcie_demo";

int dev_open(char * node)
{
    const char *filename = driver_node;
    if (node && *node) {
        filename = node;
    }
    return open(filename, O_RDWR);
}

int dev_close(int fd)
{
    return close(fd);
}

void bar_writel(int fd, int bar, uint32_t offset, uint32_t value)
{
    int ret;
    struct gowin_iotcl_param param = {0,};

    if (bar < 0) param.bar_idx = 0;
    else if (bar > 5) param.bar_idx = 5;
    else param.bar_idx = bar;

    param.bar_type = 2;
    param.bar_offset = offset;
    param.bar_dword = value;

    ret = ioctl(fd, GOWIN_BAR_WRITE_DWORD, &param);
    if (ret) {
        fprintf(stderr, "ioctl: %s\n", strerror(errno));
    }
}

uint32_t bar_readl(int fd, int bar, uint32_t offset)
{
    struct gowin_iotcl_param param = {0,};

    if (bar < 0) param.bar_idx = 0;
    else if (bar > 5) param.bar_idx = 5;
    else param.bar_idx = bar;

    param.bar_type = 2;
    param.bar_offset = offset;

    if (ioctl(fd, GOWIN_BAR_READ_DWORD, &param)) {
        fprintf(stderr, "ioctl: %s\n", strerror(errno));
        return ~0u;
    }
    return param.bar_dword;
}

void cfg_writel(int fd, uint32_t offset, uint32_t value)
{
    struct gowin_iotcl_param param = {0,};

    param.cfg_type = 2;
    param.cfg_where = offset;
    param.cfg_dword = value;

    if (ioctl(fd, GOWIN_CONFIG_WRITE_DWORD, &param)) {
        fprintf(stderr, "ioctl: %s\n", strerror(errno));
    }
}

uint32_t cfg_readl(int fd, uint32_t offset)
{
    struct gowin_iotcl_param param = {0,};

    param.cfg_type = 2;
    param.cfg_where = offset;

    if (ioctl(fd, GOWIN_CONFIG_READ_DWORD, &param)) {
        fprintf(stderr, "ioctl: %s\n", strerror(errno));
        return ~0u;
    }
    return param.cfg_dword;
}

uint64_t request_mem(int fd, int index, size_t size)
{
    struct gowin_iotcl_param param = {0,};
    param.dma_idx = index;
    param.dma_size = size;
    param.dma_realloc = 1;
    if (ioctl(fd, GOWIN_REQUEST_DMA_MEM, &param)) {
        fprintf(stderr, "ioctl: %s\n", strerror(errno));
        return 0;
    }
    return param.dma_handle;
}

void release_mem(int fd, int index)
{
    struct gowin_iotcl_param param = {0,};
    param.dma_idx = index;
    if (ioctl(fd, GOWIN_RELEASE_DMA_MEM, &param)) {
        fprintf(stderr, "ioctl: %s\n", strerror(errno));
    }
}

static void switch_bar_or_mem(int fd, int bar, int index)
{
    struct gowin_iotcl_param param = {0,};
    param.dma_select = bar == 0 ? 1 : 0;
    param.index = index;
    if (ioctl(fd, GOWIN_SWITCH_BAR_OR_MEM, &param)) {
        fprintf(stderr, "ioctl: %s\n", strerror(errno));
    }
}

void *mmap_mem(int fd, int index, size_t length)
{
    switch_bar_or_mem(fd, 0, index);
    void *ptr = mmap(NULL, length, PROT_WRITE | PROT_READ , MAP_SHARED, fd, 0);
    return (ptr == MAP_FAILED) ? NULL : ptr;
}

void *mmap_bar(int fd, int index, size_t length)
{
    switch_bar_or_mem(fd, 1, index);
    void *ptr = mmap(NULL, length, PROT_WRITE | PROT_READ , MAP_SHARED, fd, 0);
    return (ptr == MAP_FAILED) ? NULL : ptr;
}
