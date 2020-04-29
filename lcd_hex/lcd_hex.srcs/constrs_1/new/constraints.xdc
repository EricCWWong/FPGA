############## NET - IOSTANDARD ##################
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
#############SPI Configurate Setting##################
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design] 
set_property CONFIG_MODE SPIx4 [current_design] 
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design] 

create_clock -period 20 [get_ports sys_clk_i]
set_property IOSTANDARD LVCMOS33 [get_ports {sys_clk_i}]
set_property PACKAGE_PIN Y18 [get_ports {sys_clk_i}]

set_property IOSTANDARD LVCMOS33 [get_ports {rst_i}]
set_property PACKAGE_PIN F20 [get_ports {rst_i}]

#############LCD Digit Setting###########################
set_property PACKAGE_PIN J5 [get_ports {digit_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_o[0]}]

set_property PACKAGE_PIN M3 [get_ports {digit_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_o[1]}]

set_property PACKAGE_PIN J6 [get_ports {digit_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_o[2]}]

set_property PACKAGE_PIN H5 [get_ports {digit_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_o[3]}]

set_property PACKAGE_PIN G4 [get_ports {digit_o[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_o[4]}]

set_property PACKAGE_PIN K6 [get_ports {digit_o[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_o[5]}]

set_property PACKAGE_PIN K3 [get_ports {digit_o[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_o[6]}]

set_property PACKAGE_PIN H4 [get_ports {digit_o[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_o[7]}]

#############LCD Sel Setting#############################
set_property PACKAGE_PIN M2 [get_ports {sel_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sel_o[0]}]

set_property PACKAGE_PIN N4 [get_ports {sel_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sel_o[1]}]

set_property PACKAGE_PIN L5 [get_ports {sel_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sel_o[2]}]

set_property PACKAGE_PIN L4 [get_ports {sel_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sel_o[3]}]

set_property PACKAGE_PIN M16 [get_ports {sel_o[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sel_o[4]}]

set_property PACKAGE_PIN M17 [get_ports {sel_o[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sel_o[5]}]
