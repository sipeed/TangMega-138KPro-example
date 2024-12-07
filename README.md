[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)    [![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)  

# Tang Mega 138K Pro example

---
板卡介绍: [点我](https://wiki.sipeed.com/hardware/zh/tang/tang-mega-138k/mega-138k.html)
Introduction: [Click me](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k.html)
---

## Examples

This repository is being reorganized, and the verified DEMOs will be marked with ✅.


If you have any suggestions for these routines or find any bugs, please submit an issue.

***

### ae350_customized_demo

Demo for FPGA Integrated SOC AE350

Status: Unreviewed

TODOs:

- [x] Transplant GOWIN official ref_design
- [x] Check and upload the new demo.

<br>

***

### audio

Play music or sine wave audio using the onboard audio DAC

<br>

***

### cam2hdmi_alt ✅

Output the images captured by OV5640 via DVI (HDMI)

<br>

***

### ddr_test ✅

An example to test onboard ddr memory, use the onboard LEDs or GAO to view the results.

<br>

***

### dvp_rgb

Demo with OV5640 camera and 480x272 rgb_screen.

Status: Unreviewed

TODOs:

- [ ] Add support for other screen resolutions(In progress)
- [ ] Check and upload the new demo.

<br>

***

### key_led  ✅

6 Leds with 3 Function keys.

<br>

***

### led

6 Leds with 1 Reset Keys

<br>

***

#### simple_video_out

Dual Hdmi Display example based on [svo](https://github.com/cliffordwolf/SimpleVOut)

![svo_example](./.assets/svo_example.png)

<br>

***

### pro_ddr_test ✅

Another example to test onboard ddr memory, use uart to view test results.

<br>

***

### rgb_screen

Demo to test RGB Screen.

<br>

***

### pcie_dma_demo 

Pcie Demo. Read its PDF for more information.

![pcie_speed_demo](./.assets/pcie_speed_demo.png)

Status: Unreviewed

TODOs:
- [ ] Transplant [DEMO for 138K](https://github.com/sipeed/TangMega-138K-example/tree/main/pcie_dma_demo)(In progress)
- [ ] Check and upload the new demo.

<br>

***

### SFP+ ✅

**customized_phy**: Read [Gowin Customized PHY IP](sfp+/docs/manual/IPUG1024-1.5E_Gowin_Customized_PHY_IP%20User_Guide.pdf) For more information.

**10G_Serial_Ethernet**: DEMO for 10GbE Ethernet UDP Send Test Using SFP+.

### udp_rgmii_send

DEMO for 1GbE Ethernet UDP Send Test Using RJ45.

<br>

***

### usb2_soft ✅

A series about USB2 soft_PHY demo.
Support both high-speed & full-speed, use the onboard USB-C port marked **SOFT-USB**.

TODOs:
- [ ] Add **WINUSB** demo.

<br>

***

### ws2812

A demo to drive onboard ws2812, without reset key.

<br>

***
