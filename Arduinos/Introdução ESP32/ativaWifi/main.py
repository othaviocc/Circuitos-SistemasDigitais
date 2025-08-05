from rede import ativaWifi
from machine import Pin, reset
from neopixel import NeoPixel
from requests import get
from time import sleep

lat = -32.035
lon = -52.0986
var = 'temperature_2m,relative_humidity_2m,is_day,weather_code'

url = f'https://api.open-meteo.com/v1/forecast?latitude={lat}&longitude={lon}&current={var}'

led = NeoPixel(Pin(18, Pin.OUT), 1)
led[0] = (0, 0, 0)
led.write()

rw = ativaWifi ('Wokwi-GUEST','')
if rw:
    led[0] = (0, 255, 0)
    led.write()
    rsp = get(url)
    dados = rsp.json()
    rsp.close()
    print (f'Temperatura: {dados['current']['temperature_2m']} °C')
    print (f'Umidade do ar: {dados['current']['relative_humidity_2m']} %')
    print (f'Condições: {dados['current']['weather_code']}')
    if dados['current']['is_day']:
      led[0] = (255, 255, 0)
      led.write()
    else:
      led[0] = (0, 0, 255)
      led.write()
else:
    led[0] = (255, 0, 0)
    led.write()
    sleep(4)
    reset()

