############## NET - IOSTANDARD ##################
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
#############SPI Configurate Setting##################
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design] 
set_property CONFIG_MODE SPIx4 [current_design] 
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design] 

create_clock -period 20 [get_ports i_clock]
set_property IOSTANDARD LVCMOS33 [get_ports {i_clock}]
set_property PACKAGE_PIN Y18 [get_ports {i_clock}]

set_property IOSTANDARD LVCMOS33 [get_ports {rst}]
set_property PACKAGE_PIN F20 [get_ports {rst}]
#############LED Setting###########################
set_property PACKAGE_PIN F19 [get_ports {o_led_drive[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_led_drive[0]}]

set_property PACKAGE_PIN E21 [get_ports {o_led_drive[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_led_drive[1]}]

set_property PACKAGE_PIN D20 [get_ports {o_led_drive[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_led_drive[2]}]

set_property PACKAGE_PIN C20 [get_ports {o_led_drive[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_led_drive[3]}]
