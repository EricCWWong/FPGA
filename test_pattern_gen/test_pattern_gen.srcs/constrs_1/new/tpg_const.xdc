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