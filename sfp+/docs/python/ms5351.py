import os, serial, time
import argparse

def test():
    try:  
        parser = argparse.ArgumentParser()
        parser.add_argument('--com', type=str, default=None)
        print("开始测试 MS5351 ")    
        s = parser.parse_args().com
        ser=serial.Serial("COM"+s,115200)
        time.sleep(.500)
        ser.write((b'\x18')) # Ctrl + x
        ser.write((b'\x03')) # Ctrl + c
        ser.write((b'\n')) # Enter
        (ser.write((b"pll_switch 0\n")))
        # (ser.write((b"pll P0:25 D0@P0:4 D1@P0:4 O0@D0:0,0 O1@D0:0,1\n"))) #156.25MHz
        (ser.write((b"pll P0:36 D0@P0:9 D1@P0:9 O0@D0:0,0 O1@D0:0,1\n")))   #100MHz
        # (ser.write((b"pll P0:30 D0@P0:6 D1@P0:6 O0@D0:0,0 O1@D0:0,1\n"))) #125MHz
        (ser.write((b"pll_clk -s\n")))
        (ser.write((b"pll_switch 1\n")))
        # (ser.write((b"pll P0:25 D0@P0:4 D1@P0:4 O0@D0:0,0 O1@D0:0,1\n"))) #156.25MHz
        # (ser.write((b"pll P0:36 D0@P0:9 D1@P0:9 O0@D0:0,0 O1@D0:0,1\n"))) #100MHz
        (ser.write((b"pll P0:30 D0@P0:6 D1@P0:6 O0@D0:0,0 O1@D0:0,1\n")))   #125MHz
        (ser.write((b"pll_clk O2=16M\n")))
        (ser.write((b"pll_clk -s\n")))
        time.sleep(.500)
        print("设置 MS5351 成功\r\n")
    except:
        ser.close()
        print("设置 MS5351 失败\r\n")

test()