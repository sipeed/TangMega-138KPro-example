# Cam2DVI - a DVP Camera DVI(HDMI) demo for Sipeed Tang MEGA 138K FPGA Boards

This project is a demo to test the DVP Camera, DDR3 memory & HDMI on GOWIN GW5AST-138K, it base on Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html), it uses the DDR3 memory as framebuffer on the board for video capture & output testing.

# Main features

- 720P@60/30Hz TMDS video output via HDMI connector.
- 720P@60/30Hz RGB565 video capture via DVP Camera OV5640.
- Use on board DDR3 memory as framebuffer.

This demo now is only test on Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html), which mainchip is **GW5AST-LV138FP676AC1/l0** or **GW5AST-LV138FP676AES**.   

## Directory structure

```
| -- docs                       --> manuals and documentation  
|    |--IPUG769-2.0             --> Gowin Video Frame Buffer IP User Guide(CN)
|    |--IPUG769-2.0E            --> Gowin Video Frame Buffer IP User Guide(EN)
|    |`-- images                --> picture resources  
| -- cam2dvi 
|    |-- src                    --> project sources 
|    |-- impl                   --> project config & implementation 
|    |
|    |`-- cam2dvi.fs.7z         --> prbuild bitstream(zipped)                       
|    |`-- cam2dvi.gprj          --> demo project
|    |`-- cam2dvi.gprj.user     --> project conf.

```

## Getting start
Please confirm that you have the following conditions:
- GOWIN IDE Version ≥ 1.9.9
- **DO NOT** use GOWIN Programmer version **1.9.10.02**, for this version contains many issues with **onboard debugger**.
~~ - You can get a windows GOWIN Programmer version **1.9.10.03** Alpha for [HERE](https://api.dl.sipeed.com/shareURL/TANG/programmer) ~~ GOWIN has released an update version **1.9.10.03**.
- Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html)
- An OV5640 Sensor, a HDMI/DVI Monitor and a HDMI cable.
- USB-C date cable, use to connect the board to your PC.

***

## Important 

⚠️ **Beware of HIGH temperatures**⚠️ :

The OV5640 will generate a lot of heat when outputting 720P/60Hz RGB565 images. Please pay attention to the heat dissipation of the sensor. Avoid direct contact with the heated sensor.

This demo has disabled the internal 1V5 regulator of the OV5640, but it still generates a lot of heat. A lower VDDIO(even 1V8) can alleviate the heat, but if you don't add a heat sink to the sensor, the sensor will eventually overheat.

Overheating may cause the OV5640 to output abnormal images or even burn out the OV5640.

Lowering the output frame rate, resolution, and disabling the internal ISP to let the OV5640 output RAW can greatly reduce heat.

Therefore, this demo is not recommended to be used for a long time without cooling the sensor. If anyone knows how to solve this problem, please submit an issue.Your help is important to everyone.

***

## How to use

Here are quick instructions for the more experienced,
- Assemble your sensor and board, then connect it to your monitor via an HDMI cable.
- Note that the USB cable must be connected to the USB-C port on the side with the **JTAG|UART** mark.
- Download & Complie the project, then downloading the bitstream to you board.
- You can also try using the prebuilt bitstream, but remember to unzip it before downloading.
- Observe whether the monitor is show the screen captured by the sensor correctly.


## LEDs & button

This demo uses 5 LEDs to indicate status 
Here are the details for LEDs:(LED0 is on the far right)
| LEDs      | Description                     | Expected situation|
| ----------| --------------------------------|-------------------|
| LED0      |  DDR3 initialization            | ON                |
| LED1      |  DDR3_pll_lock                  | ON                |
| LED2      |  TMDS_pll_lock                  | ON                |
| LED3      |  cmos_vs_cnt                    | Blink             |
| LED4      |  cmos_i2c_done                  | ON                |

1 button **(S0)** use to reset the transmission.  

## Development
If you want to modify the video resolution output, Please refer to the comments in the top file.

Changing the resolution requires changing the output of TMDS_PLL. 

For specific frequency values, please refer to the relevant VESA documents.

To change the output of OV5640, please refer to the *lut_ov5640_rgb565_1280_720.v* in project.
