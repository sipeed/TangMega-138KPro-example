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

#ifndef __GOWIN_PCIE_DRV_UAPI_H
#define __GOWIN_PCIE_DRV_UAPI_H

#define PCITEST_BAR             _IO('P', 0x1)
#define PCITEST_LEGACY_IRQ      _IO('P', 0x2)
#define PCITEST_MSI             _IOW('P', 0x3, int)
#define PCITEST_WRITE           _IOW('P', 0x4, unsigned long)
#define PCITEST_READ            _IOW('P', 0x5, unsigned long)
#define PCITEST_COPY            _IOW('P', 0x6, unsigned long)
#define PCITEST_MSIX            _IOW('P', 0x7, int)
#define PCITEST_SET_IRQTYPE     _IOW('P', 0x8, int)
#define PCITEST_GET_IRQTYPE     _IO('P', 0x9)
#define PCITEST_CLEAR_IRQ       _IO('P', 0x10)

#define PCITEST_FLAGS_USE_DMA   0x00000001

struct gowin_test_param {
    unsigned long size;
    unsigned char flags;
};

#endif //! __GOWIN_PCIE_DRV_UAPI_H