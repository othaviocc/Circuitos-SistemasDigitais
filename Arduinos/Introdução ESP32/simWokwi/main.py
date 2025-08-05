from machine import Pin
from time import sleep_ms
from rede import ativaWifi
from umqtt.robust import MQTTClient

net = 'Wokwi-GUEST'
pas = ''

clientId = 'crrifrsrg'
broker = 'broker.hivemq.com'
topChave = b'casa/sala/luminaria/chave'
topLumin = b'casa/sala/luminaria/status'


def cb(t, p):
  global cr

  if t == topChave:
    if p == b'muda':
      cr = not cr


def conectaBroker(cid, brk, tChave):
  c = MQTTClient(cid, brk)
  c.set_callback(cb)
  c.connect()
  c.subscribe(tChave)
  return c


rw = ativaWifi (net, pas)
if rw:
  cliente = conectaBroker(clientId, broker, topChave)    
else:
  print ('Sem rede')

chave = Pin(14, Pin.IN, Pin.PULL_UP)
carga = Pin(23, Pin.OUT)

carga.value(0)
cr = crAnt = 0
chAnt = ch = 1

while True:
  if rw:
    if rw.isconnected():
      cliente.check_msg()
    else:
      rw = reconecta(rw, net, pas)
      
  ch = chave.value()
  if ch != chAnt:
    cr = not cr
    chAnt = ch
    sleep_ms(250)

  if cr != crAnt:
    carga.value(cr)
    crAnt = cr
    if rw and rw.isconnected():
      print ('foi')
      msg = b'ligado' if cr else b'desligado'
      cliente.publish (topLumin, msg)
