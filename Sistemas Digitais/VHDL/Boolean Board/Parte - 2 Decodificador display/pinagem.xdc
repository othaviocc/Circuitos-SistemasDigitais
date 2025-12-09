set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports i_clock]
set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports i_reset]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports i_w]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports i_linha]
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports i_coluna]

## switchs
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {i_d[0]}]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {i_d[1]}]
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports {i_d[2]}]
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS33} [get_ports {i_d[3]}]
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {i_d[4]}]
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {i_d[5]}]
set_property -dict {PACKAGE_PIN R1 IOSTANDARD LVCMOS33} [get_ports {i_d[6]}]
set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS33} [get_ports {i_d[7]}]

## segmentos do display(g,f,e,d,c,b,a)
set_property -dict {PACKAGE_PIN B5 IOSTANDARD LVCMOS33} [get_ports {o_segmentos[6]}]
set_property -dict {PACKAGE_PIN D6 IOSTANDARD LVCMOS33} [get_ports {o_segmentos[5]}]
set_property -dict {PACKAGE_PIN A7 IOSTANDARD LVCMOS33} [get_ports {o_segmentos[4]}]
set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {o_segmentos[3]}]
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports {o_segmentos[2]}]
set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports {o_segmentos[1]}]
set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVCMOS33} [get_ports {o_segmentos[0]}]

## anodos
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports {o_anodos[0]}]
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports {o_anodos[1]}]
set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports {o_anodos[2]}]
set_property -dict {PACKAGE_PIN A8 IOSTANDARD LVCMOS33} [get_ports {o_anodos[3]}]
