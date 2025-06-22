################ Definições #################
from PySpice.Spice.Netlist import Circuit   # bliblioteca principal PySpice
from PySpice.Unit import *                  # unidades utilizadas
#############################################

################# Circuito ##################
circuit = Circuit('Circuito')               # cria circuito
circuit.V(1,  1 ,  0 ,   40@u_V )           # .V(label, +nó, -nó, val)
circuit.V(2,  2 ,  0 ,   20@u_V )           #
circuit.R(1,  1 , 'a',  100@u_Ω )           # .R(label,  nó,  nó, val)
circuit.R(2,  2 , 'b',  100@u_Ω )           #
circuit.C(1, 'o',  0 ,    2@u_mF)           # .C(label,  nó,  nó, val, <ic = 1@u_V>) -> use_initial_condition = True
#############################################

################## Chaves ###################
t0, tf, st, t_swt = -2@u_s, 1@u_s, .1@u_ms, -1@u_s
circuit.model('switch', 'SW', Ron=1@u_mΩ, Roff=1@u_GΩ)
circuit.PulseVoltageSource(3, 'ca', 0, initial_value =  1, pulsed_value = -1, pulse_width=tf-t0, period=tf-t0, delay_time=t_swt-t0)
circuit.PulseVoltageSource(4, 'cb', 0, initial_value = -1, pulsed_value =  1, pulse_width=tf-t0, period=tf-t0, delay_time=t_swt-t0)
circuit.VoltageControlledSwitch(1, 'a', 'o', 'ca', 0, model='switch')
circuit.VoltageControlledSwitch(2, 'o', 'b', 'cb', 0, model='switch')
#############################################

################ Simulação ##################
simulator = circuit.simulator()
#simulator.initial_condition(o = 0@u_V)
analysis = simulator.transient(step_time=st, end_time=tf-t0) # use_initial_condition = True
#############################################

################ Resultados #################
import matplotlib.pyplot as plt
fig, ax = plt.subplots()
plt.title('Tensão no Capacitor'); plt.xlabel('Tempo [s]'); plt.ylabel('Tensão [V]'); plt.grid()
plt.plot(analysis.time+t0,analysis.o,'b')
ax.set_yticks([40, 20, 0])
plt.show()
#############################################


#print(simulator)



#import PySpice.Logging.Logging as Logging
#logger = Logging.setup_logging()




