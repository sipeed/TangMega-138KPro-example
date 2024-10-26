MODULE_NAME=gowin_demo
# object files to build
obj-m += ${MODULE_NAME}.o
${MODULE_NAME}-objs += gowin_demo_drv.o

mod:
	make -C /lib/modules/$(shell uname -r)/build M=${srcdir}/driver modules
	strip --strip-debug ${MODULE_NAME}.ko

app:
	make -C 

clean:
	make -C /lib/modules/$(shell uname -r)/build M=${srcdir} clean
	rm -rf Module.symvers

