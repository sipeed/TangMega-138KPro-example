
#ifndef MAX_DMA_CTX_NUM
#define MAX_DMA_CTX_NUM     16
#endif

int dev_open(char * node);
int dev_close(int fd);


void bar_writel(int fd, int bar, uint32_t offset, uint32_t value);
uint32_t bar_readl(int fd, int bar, uint32_t offset);

void cfg_writel(int fd, uint32_t offset, uint32_t value);
uint32_t cfg_readl(int fd, uint32_t offset);

uint64_t request_mem(int fd, int index, size_t size);
void release_mem(int fd, int index);

void *mmap_mem(int fd, int index, size_t length);
void *mmap_bar(int fd, int index, size_t length);