#
#/*
# * This file is part of the QDMA userspace application
# * to enable the user to execute the QDMA functionality
# *
# * Copyright (c) 2018-2022,  Xilinx, Inc.
# * All rights reserved.
# *
# * This source code is licensed under BSD-style license (found in the
# * LICENSE file in the root directory of this source tree)
# */

SHELL = /bin/bash

CFLAGS += -g
#CFLAGS += -O2 -fno-inline -Wall -Wstrict-prototypes
CFLAGS += -I. -I../include -I../libs
CFLAGS += $(EXTRA_FLAGS)

DMA-DEMO = dma_demo
DMA-DEMO_OBJS := $(patsubst %.c,%.o,$(wildcard *.c))
DMA-DEMO_OBJS += $(patsubst %.c,%.o,$(wildcard ../libs/*.c))

ifneq ($(CROSS_COMPILE_FLAG),)
	CC=$(CROSS_COMPILE_FLAG)gcc
endif
 
all: clean dma_demo-a

dma_demo-a: $(DMA-DEMO_OBJS)
	$(CC) $^ -o $(DMA-DEMO) -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -D_LARGE_FILE_SOURCE
#	$(CC) -pthread -lrt $^ -o $(SIMPLE-DEMO) -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -D_LARGE_FILE_SOURCE
	
%.o: %.c
	$(CC) $(CFLAGS) -c -std=c11 -o $@ $< -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -D_LARGE_FILE_SOURCE -D_AIO_AIX_SOURCE

clean:
	@rm -f *.o */*.o ../libs/*.o $(SIMPLE-DEMO)
