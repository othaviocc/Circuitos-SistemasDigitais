from machine import Pin,PWM,ADC
from time import ticks_add,ticks_diff,ticks_ms

DT=const(500)
led=PWM(Pin(25))
pot=ADC(Pin(4))
tle=ticks_ms()

while True:
    if ticks_diff(ticks_ms(), tle)>=DT:
        v=pot.read_u16()
        print(f'valor: {v}, V: {3.3*v/65535}')
        led.duty_u16(v)
        tle=ticks_add(ticks_ms(), DT)

