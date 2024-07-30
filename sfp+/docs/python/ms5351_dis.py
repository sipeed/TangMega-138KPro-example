import os, serial, time
import argparse

def test():
    try:  
        parser = argparse.ArgumentParser()
        parser.add_argument('--com', type=str, default=None)
        print("禁用 MS5351 ")    
        s = parser.parse_args().com
        ser=serial.Serial("COM"+s,115200)
        time.sleep(.500)
        ser.write((b'\x18')) # Ctrl + x
        ser.write((b'\x03')) # Ctrl + c
        ser.write((b'\n')) # Ctrl + c
        (ser.write((b"pll_clk O0\n")))
        (ser.write((b"pll_clk O1\n")))
        (ser.write((b"pll_clk O2\n")))
        (ser.write((b"pll_clk -s\n")))
        time.sleep(.500)
        print("操作成功，换下一个板卡开始测试")
    except:
        ser.close()
        print("禁用 MS5351 失败\r\n")

test()   