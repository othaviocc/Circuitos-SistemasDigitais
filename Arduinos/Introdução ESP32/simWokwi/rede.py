from network import WLAN, STA_IF
from time import sleep_ms


def ativaWifi(rede, senha):
    # Retorna True se consegue conectar à rede, ou False do contrário
    # Faz 10 tentativas, separadas por 1s de tempo
    wifi = WLAN(STA_IF)
    wifi.active(True)
    if not wifi.isconnected():
        wifi.connect(rede, senha)
        tentativas = 0
        while not wifi.isconnected() and\
                  tentativas < 10:
            sleep_ms(1000)
            tentativas += 1
    return wifi if wifi.isconnected() else None


def reconecta(wifi, rede, senha):
    # Retorna True se consegue conectar à rede, ou False do contrário
    # Faz 10 tentativas, separadas por 1s de tempo
    if not wifi.isconnected():
        wifi.connect(rede, senha)
        tentativas = 0
        while not wifi.isconnected() and tentativas < 10:
            sleep_ms(1000)
            tentativas += 1
    return wifi if wifi.isconnected() else None