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
CFLAGS += $(EXTRA_FLAGS)

srcdir := $(shell pwd)
topdir := $(shell cd $(srcdir)/.. && pwd)
bin_dir := $(topdir)/bin
dma_demo_dir = $(srcdir)/dma_demo

export topdir
export bin_dir

all: clean apps


.PHONY: dma-demo
dma-demo:
	@echo "#############################";
	@echo "#### make  dma-demo      ####";
	@echo "#############################";
	$(MAKE) -C $(dma_demo_dir)
	@cp -f $(dma_demo_dir)/dma_demo $(bin_dir)


.PHONY: apps
apps: dma-demo


.PHONY: clean
clean:
	@echo "#############################";
	@echo "####  clean dma-demo     ####";
	@echo "#############################";
	$(MAKE) -C $(dma_demo_dir) clean;
	@rm -f $(bin_dir)/dma_demo;
	@for dir in $(ALLSUBDIRS); do \
	   echo "#######################";\
	   printf "####  %-8s%5s####\n" $$dir;\
	   echo "#######################";\
	  drvdir=$(shell pwd)/$$dir $(MAKE) -C $$dir clean;\
	done;
#	@-/bin/rm -f *.symvers eval.mak 2>/dev/null;

