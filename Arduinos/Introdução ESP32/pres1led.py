from machine import Pin
from time import ticks_ms, sleep_ms

led = Pin(2, Pin.OUT)
bot = Pin(27, Pin.IN, Pin.PULL_DOWN)

estado = False
tAtual = ticks_ms()
b = bAnt = bot()

while True:
    b = bot()  #Atualiza o estado do botão
    if b != bAnt:  #BORDA
        if b:  #b == 1
            print("Pressionado")
            estado = not estado
            sleep_ms(400)
        bAnt = b 

    if estado:
        if ticks_ms() - tAtual >= 500:
            led.value(not led.value())      #Hora de mudar o estado
            tAtual = ticks_ms()       #Equivale a led.value()
    