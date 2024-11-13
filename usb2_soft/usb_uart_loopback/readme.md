# usb_uart_loopback
This directory is a demo of USB-Serial loopbadk devices on Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html).

***

## Main features
- Baudrate: Fixed to 115200, maybe variable baudrate will be updated in the future.
- Standard CDC-ACM device, which can be plug and play without installing drivers.
- Automatic loopback: what you send will be what you receive.

***

## Getting start
Please confirm that you have the following conditions:
- GOWIN IDE Version ≥ **1.9.9**, it is better to be ≥ **1.9.9.03**. For the IDE version used in this demo is **1.9.9.03**.
- **DO NOT** use GOWIN Programmer version **1.9.10.02**, for this version contains many issues with **onboard debugger**.
~~ - You can get a windows GOWIN Programmer version **1.9.10.03** Alpha for [HERE](https://api.dl.sipeed.com/shareURL/TANG/programmer) ~~ GOWIN has released an update version **1.9.10.03**.
- Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html)
- USB-C date cable, use to connect the board to your PC.

***

### Demonstration of demo USB devices

- What you can see in **Windows Device Manager**
![COM in Windows Device Manager](../docs/images/COM_in_Windows_Device_Manager.png "COM in Windows Device Manager")
**COM36 is the target device, Windows 10 and above do not require driver installation**

- What you can see in **USB Tree View**
![COM in USB Tree View](../docs/images/COM_in_USB_Tree_View.png "COM in USB Tree View")
**As you can see, this is a high-speed USB device**

- UART loopback test in **[COMToool](https://github.com/neutree/COMTool)**
![COMToool](../docs/images/COMTOOL.png "COM in USB Tree View")
**Open COM36 in COMTool, set baudrate to 115200,than send anything you want**

- How it works
![Working_principle](../docs/images/Working_principle.png "Working principle")
**Open COM36 in COMTool, set baudrate to 115200,than send anything you want**

## LEDs & button

This demo uses 6 LEDs to indicate status 
Here are the details for LEDs:(LED0 is on the far right)
| LEDs      | Description                     | Expected situation|
| ----------| --------------------------------|-------------------|
| LED0      |  Running indicator              | Blink             |
| LED1      |  Main PLL Locked                | ON                |
| LED2      |  System reset enabled           | OFF               |
| LED3      |  PHY FS Mode*                   | OFF               |
| LED4      |  PHY LS Mode*                   | OFF               |
| LED4      |  Device is High-Speed           | ON                |

Note: LED[3:4] **ALL OFF** when PHY is in HS mode.

## Development
TBD
