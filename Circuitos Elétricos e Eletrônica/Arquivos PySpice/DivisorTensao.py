################ Definições #################
from PySpice.Spice.Netlist import Circuit   # bliblioteca principal PySpice
from PySpice.Unit import u_V, u_kΩ, u_kOhm  # unidades utilizadas
#############################################

################# Circuito ##################
circuit = Circuit('Circuito')               # cria circuito
circuit.V(1, 1, 0,  5@u_V   )               # .V(label, +nó, -nó, val)
circuit.R(1, 1, 2,  1@u_kΩ  )               # .R(label,  nó,  nó, val)
circuit.R(2, 2, 0,  2@u_kOhm)               # .R(label,  nó,  nó, val)
#############################################

################ Simulação ##################
#circuit.R1.plus.add_current_probe(circuit) # adiciona ponta no ramo R1
simulator = circuit.simulator()             # compila/agrupa circuito
analysis = simulator.operating_point()      # tipo de análise
#############################################

################ Resultados ########################
for no in analysis.nodes.values():                 # para cada nó
    print(f'Nó {no}: {float(no):5.2f} V')          #    imprime tensões
for rm in analysis.branches.values():              # para cada ramo analisado
    print(f'Corrente em {rm}: {float(rm):5.5} A')  #    imprime correntes
####################################################

#print(simulator)



#import PySpice.Logging.Logging as Logging
#logger = Logging.setup_logging()
#circuit.I(1, 0, 1,  1@u_A)
