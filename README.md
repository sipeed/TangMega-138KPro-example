# Tang Mega 138K Pro example

---
板卡介绍: [点我](https://wiki.sipeed.com/hardware/zh/tang/tang-mega-138k/mega-138k.html)
Introduction: [Click me](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k.html)
---

## Examples

### ae350_customized_demo

Demo for FPGA Integrated SOC AE350

Status: Unreviewed

TODOs:

- [ ] Transplant GOWIN official ref_design(In progress)
- [ ] Check and upload the new demo.

### audio

Play music or sine wave audio using the onboard audio DAC

### cam2hdmi_alt

Output the images captured by OV5640 via DVI (HDMI)

### ddr_test

An example to test onboard ddr memory, use the onboard LEDs or GAO to view the results.

### dvi

2 dvi intefaces both supports video out.

### dvp_rgb

Demo with OV5640 camera and 480x272 rgb_screen.

### key_led

6 Leds with 5 Reset keys.

### led

6 Leds with 1 Reset Keys

#### svo

Dual Hdmi Display example based on [svo](https://github.com/cliffordwolf/SimpleVOut)

![svo_example](./.assets/svo_example.png)

### pro_ddr_test

Another example to test onboard ddr memory, use uart to view test results.

### rgb_screen

Demo to test RGB Screen.

### Pcie

Pcie Demo. Read its PDF for more information.

![pcie_speed_demo](./.assets/pcie_speed_demo.png)

Status: Unreviewed

TODOs:
- [ ] Transplant [DEMO for 138K](https://github.com/sipeed/TangMega-138K-example/tree/main/pcie_dma_demo)(In progress)
- [ ] Check and upload the new demo.

### SFP+

**customized_phy**: Read [Gowin Customized PHY IP](sfp+/docs/IPUG1024-1.5E.pdf) For more information.

**10G_Serial_Ethernet**: DEMO for 10GbE Ethernet UDP Send Test Using SFP+.

### udp_rgmii_send

DEMO for 1GbE Ethernet UDP Send Test Using RJ45.

### ws2812

A demo to drive onboard ws2812, without reset key.