[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

# key_led_demo - a basic led & key test demo for Sipeed Tang MEGA 138K Pro FPGA Boards

This project is a basic function test on GOWIN GW5AST-138K, it base on Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html), and uses the **6 LEDs** on the dockboard for IO control LED on/off testing.

## Main features

- Sequentially illuminated 6 LEDs
- 3 different clock source inputs can be selected: Internal_OSC, Onboard_OSC or MS5351
- 3 different keys to switch LEDs blink status

image TBD
<!-- <img src="docs/images/NEO_PMOD_LED.webp" width=400>  -->

This demo is forked from the pmod_led demo of Sipeed [Tang MEGA 138K](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k.html), which mainchip is **GW5AST-LV138PGG484AC1/l0** or **GW5AST-LV138PG484AES**.  
And it now is tested on  Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html), which mainchip is **GW5AST-LV138FPGG676AC1/l0** or **GW5AST-LV138FPGG676AES**. 

## Directory structure

```
|
| -- docs                         --> manuals and documentation
|    |`-- UG306E.pdf              --> official Clock resource guide（en） 
|    |`-- UG306_zh.pdf            --> official Clock resource guide(zh) 
|     `-- images                  --> picture resources                           
|-- src                           --> project sources
|-- impl                          --> project config & implementation  
|
|`-- key_led.fs.7z                --> prbuild bitstream(zipped)
|`-- key_led.gprj.user            --> project conf.
|`-- key_led.gprj                 --> demo project
|

```
## Getting start
Please confirm that you have the following conditions:
- GOWIN IDE Version ≥ 1.9.10
- **DO NOT** use GOWIN Programmer version **1.9.10.02**, for this version contains many issues with **onboard debugger**(BL616).
- ~~You could set the *CPU as regular IO* in **IDE-Project-Configuration-Place & route-Dual Purpose Pin**, otherwise you will get a **ERROR** from IDE like *The constrained location is useless in current package* when running placement.~~

## How to use

image TBD
<img src="docs/images/PEO_KEY_LED.webp" width=400> 

- Download & Complie the project, then downloading the bitstream to you board.
- You can also try using the prebuilt bitstream, but remember to unzip it before downloading.
- Check whether 6 LEDs lighting up one by one from one side to the other side, then turn off one by one.
- Press button S1 or S2 to change the blink status of LEDs.

## LEDs & button
This project uses 6 LEDs to achieve the effect of running lights.

Here are the details for buttons: 
(S0 is on the far left)

| buttons   | Description                     | Expected situation|
| ----------| --------------------------------|-------------------|
| S0        |  Pressed the reset key(S0)      | ALL LEDs OFF      |
| S1        |  Pressed the S1                 | ALL LEDs BLINK    |
| S2        |  Pressed the S2                 | ALL LEDs OFF      |
| NONE      |  No keys are pressed            | ALL LEDs MARQUEE  |

## Development
If you want to modify the change the speed of flashing, Please refer to the comments in the top file and the cst file.
When using CKO2 of MS5351 as the system clock input, you can refer to [SET_5351](https://github.com/sipeed/TangMega-138KPro-example/blob/main/sfp%2B/docs/SET_5351.md) to change the frequency of its output clock.

