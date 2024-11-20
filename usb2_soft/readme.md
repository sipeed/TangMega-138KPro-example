# USB2_Soft - A series about USB2 soft_PHY demo for Sipeed Tang MEGA 138K FPGA Boards

This directory is a series demo to test the **USB2** `soft_PHY` & `device_controller` on GOWIN GW5AST-138K, it base on Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html), it uses the USB-C port marked with **SOFT-USB** to connect to PC. Users could realize custom USB devices with ether **high-speed(480Mbps)** or **full-speed(12Mbps)** by develop with these example.

***

# Main features

- Solution without any chip, only need **RC network** & **9 FPGA pins**.
- Provides a custom USB2 controller, both **high-speed(480Mbps)** or **full-speed(12Mbps)**.
- Up to 16 custom IN/OUT USB EndPoints.
- Transfer rate up to 39.8MB/s(318.4Mbps).


<div style="display: flex; flex-direction: column;"> 
  <div style="display: flex; justify-content: space-around; gap: 10px; width: 100%;">
    <img src="./docs/images/HS_BULK_IN.png" alt="HS_BULK_IN." style="width: 45%;"/>
    <img src="./docs/images/HS_BULK_OUT.png" alt="HS_BULK_OUT" style="width: 45%;"/>
  </div> 
    <div style="margin-top: 10px; text-align: left;"> Speed test with <b>Cypress C++ Streamer</b>(Need to install <b>Cypress</b> proprietary driver)</div> 
  </div>

  ***

  This demo now is only test on Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html), which mainchip is **GW5AST-LV138FP676AC1/l0** or **GW5AST-LV138FP676AES**.  

***

## Directory structure

```
| -- docs                             --> manuals and documentation   
|    |`-- images                      --> picture resources  
|    |`-- manuals                     --> official manual from GOWIN
|
| -- usb_uart_loopback                --> project for usb to uart loopback
|    |-- src                          --> project sources 
|    |-- impl                         --> project config & implementation 
|    |
|    |`-- usb_uart_loopback.fs.7z     --> prbuild bitstream(zipped)                       
|    |`-- usb_uart_loopback.gprj      --> demo project
| -- usb_cy_streamer                  --> project for speedtest(need Cypress FX3 driver)
...
...(The following is omitted)

```
⚠️ Note: Please refer to the relevant documents for the use of Cypress C++ streamer/bulkloop. Related programs and drivers are not provided here.

## How to use

See the corresponding project's readme for details
- [usb_uart_loopback](./usb_uart_loopback/readme.md)
- [usb_cy_streamer](./usb_cy_streamer/readme.md)
- [cy_usb_bulkloop](./usb_cy_bulkloop/readme.md)

***

## Troubleshoot

### FAQ

- **Q:** Can I use this demo with **[138K (NEO) Dock](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k.html)** ?
  
  **A:** No, it just work with **[Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html)**. USB demo for **[138K (NEO) Dock](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k.html)** is ***[ch569_hspi2cdc](https://github.com/sipeed/TangMega-138K-example/tree/main/ch569_hspi2cdc)***.

  ***

- **Q:** USB cannot be recognized or error with USB device.

- **A:** Possible reasons are as follows:
    
    1. The board is not powered enough and needs to be connected to an aux power supply, usually it is the **12V DC** jack.

    2. The USB cable used is too long or of poor quality. Generally, the length of the USB cable is not recommended to exceed 1m, and 0.5m is best. 

    3. Maybe there's just a minor issue with your computer's USB host controller. 
    Replugging the USB cable may fix it. 

***

- **Q:** Where could I get those tools for test?

  **A:** For the UART test, There are many such tools. We recommend you use the one you like, or you can use this [COMToool](https://github.com/neutree/COMTool).

  For the test with *Cypress Proprietary Tools*, The relevant tools can be found on the [Infineon official website](https://softwaretools.infineon.com/tools/com.ifx.tb.tool.ezusbfx3sdk) here.

***

If you have any other problems, please submit an issue to this repository.
