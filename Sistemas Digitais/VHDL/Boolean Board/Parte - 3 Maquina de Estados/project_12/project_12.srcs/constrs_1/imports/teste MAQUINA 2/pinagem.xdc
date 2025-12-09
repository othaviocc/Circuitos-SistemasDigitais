set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports i_clock]
set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports i_reset]

## RGB verm, verde, azul
set_property -dict {PACKAGE_PIN V6 IOSTANDARD LVCMOS33} [get_ports {o_led_rgb[0]}] 
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {o_led_rgb[1]}] 
set_property -dict {PACKAGE_PIN U6 IOSTANDARD LVCMOS33} [get_ports {o_led_rgb[2]}]

## Segmento direitop
## Anodos 
set_property -dict {PACKAGE_PIN H3 IOSTANDARD LVCMOS33} [get_ports {o_an_dir[0]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {o_an_dir[1]}]
set_property -dict {PACKAGE_PIN F3 IOSTANDARD LVCMOS33} [get_ports {o_an_dir[2]}]
set_property -dict {PACKAGE_PIN E4 IOSTANDARD LVCMOS33} [get_ports {o_an_dir[3]}]

## Segmentos
set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports {o_seg_dir[0]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {o_seg_dir[1]}]
set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33} [get_ports {o_seg_dir[2]}]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports {o_seg_dir[3]}]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports {o_seg_dir[4]}]
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {o_seg_dir[5]}]
set_property -dict {PACKAGE_PIN D1 IOSTANDARD LVCMOS33} [get_ports {o_seg_dir[6]}]
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports {o_seg_dir[7]}]

## Display esq
## Anodos
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports {o_an_esq[0]}]
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports {o_an_esq[1]}]
set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports {o_an_esq[2]}]
set_property -dict {PACKAGE_PIN A8 IOSTANDARD LVCMOS33} [get_ports {o_an_esq[3]}]

## Segmentos
set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVCMOS33} [get_ports {o_seg_esq[0]}]
set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports {o_seg_esq[1]}]
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports {o_seg_esq[2]}]
set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {o_seg_esq[3]}]
set_property -dict {PACKAGE_PIN A7 IOSTANDARD LVCMOS33} [get_ports {o_seg_esq[4]}]
set_property -dict {PACKAGE_PIN D6 IOSTANDARD LVCMOS33} [get_ports {o_seg_esq[5]}]
set_property -dict {PACKAGE_PIN B5 IOSTANDARD LVCMOS33} [get_ports {o_seg_esq[6]}]
set_property -dict {PACKAGE_PIN A6 IOSTANDARD LVCMOS33} [get_ports {o_seg_esq[7]}]