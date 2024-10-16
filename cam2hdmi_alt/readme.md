# Cam2DVI - a DVP Camera DVI(HDMI) demo for Sipeed Tang MEGA 138K FPGA Boards

This project is a demo to test the DVP Camera, DDR3 memory & HDMI on GOWIN GW5AST-138K, it base on Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html), it uses the DDR3 memory as framebuffer on the board for video capture & output testing.

Main features,

- 720P@60/30Hz TMDS video output via HDMI connector.
- 720P@60/30Hz RGB565 video capture via DVP Camera OV5640.
- Use on board DDR3 memory as framebuffer .

This demo now is only test on Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html), which mainchip is **GW5AST-LV138FP676AC1/10** or **GW5AST-LV138FP676AES**.   

## Directory structure

```
| -- docs                       --> manuals and documentation   
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
- **DO NOT** use GOWIN Programmer version **1.9.10.02**, for this version contains many issues
- You can get a windows GOWIN Programmer version **1.9.10.03** Alpha for [HERE](https://api.dl.sipeed.com/shareURL/TANG/programmer)
- Sipeed [Tang MEGA 138K Pro](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k-pro.html)
- An OV5640 Sensor, a HDMI/DVI Monitor and a HDMI cable
- USB-C date cable, use to connect the board to  PC  

## How to use

Here are quick instructions for the more experienced,
- Assemble your sensor and board, then connect it to your monitor via an HDMI cable.
- Download & Complie the project, then downloading the bitstream to you board.
- You can also try using the prebuilt bitstream, but remember to unzip it before downloading.
- Observe whether the monitor is show the screen captured by the sensor correctly.


## LEDs & button

This demo uses 4 LEDs to indicate status 
Here are the details for LEDs:(LED0 is on the far right)
| LEDs      | Description                     | Expected situation|
| ----------| --------------------------------|-------------------|
| LED0      |  DDR3 initialization            | ON                |
| LED1      |  DDR3_pll_lock                  | ON                |
| LED2      |  TMDS_DDR_pll_lock              | ON                |
| LED3      |  cmos_vs_cnt                    | Blink             |
| LED4      |  cmos_i2c_done                  | ON                |

1 button **(S0)** use to reset the transmission.  

## Development
If you want to modify the video resolution output, Please refer to the comments in the top file.

Changing the resolution requires changing the output of TMDS_PLL. 

For specific frequency values, please refer to the relevant VESA documents.

To change the output of OV5640, please refer to the *lut_ov5640_rgb565_1280_720.v* in project.