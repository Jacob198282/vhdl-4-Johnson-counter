# Buttons
set_property PACKAGE_PIN U18 [get_ports clk_i]
	set_property IOSTANDARD LVCMOS33 [get_ports clk_i]
set_property PACKAGE_PIN T17 [get_ports rst_i]
	set_property IOSTANDARD LVCMOS33 [get_ports rst_i]
# LEDs
set_property PACKAGE_PIN U16 [get_ports {led_o[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_o[0]}]
set_property PACKAGE_PIN E19 [get_ports {led_o[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_o[1]}]
set_property PACKAGE_PIN U19 [get_ports {led_o[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_o[2]}]
set_property PACKAGE_PIN V19 [get_ports {led_o[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {led_o[3]}]
# the following property allows the use of a regular pin for clock input:
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_i]
## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]