from machine import Pin, I2C
import ssd1306
import mpu6050
import time


# ESP32 Pin assignment 
i2c = I2C(0, scl=Pin(22), sda=Pin(21))

oled_width = 128 # largura
oled_height = 64 # altura
oled = ssd1306.SSD1306_I2C(oled_width, oled_height, i2c)

mpu = mpu6050.MPU6050(i2c)

# wake up the MPU6050 from sleep
mpu.wake()
gyro = ""
accel = ""
temp = ""
# continuously print the data
while True:
    new_gyro = mpu.read_gyro_data()
    new_accel = mpu.read_accel_data()
    temperature = mpu.read_temperature()
    if(new_gyro != gyro or new_accel != accel or temperature != temp):
      gyro = new_gyro
      accel = new_accel
      temp = temperature
      print("Gyro: " + str(gyro) + ", Accel: " + str(accel))
      oled.fill(0)
      oled.text("Gyro", 0, 2)
      oled.text("-----------------", 0, 10)
      oled.text("x:"+ str(round(gyro[0],2)), 0, 15)
      oled.text("y:"+ str(round(gyro[1],2)), 0, 25)
      oled.text("z:"+ str(round(gyro[2],2)), 0, 35)
      oled.text("Accel", 70, 2)
      oled.text("x:"+ str(round(accel[0],2)), 70, 15)
      oled.text("y:"+ str(round(accel[1],2)), 70, 25)
      oled.text("z:"+ str(round(accel[2],2)), 70, 35)
      oled.text("Temp", 0, 45)
      oled.text("------------"+str(temperature), 0, 48)
      
      oled.show()
    time.sleep(0.1)
