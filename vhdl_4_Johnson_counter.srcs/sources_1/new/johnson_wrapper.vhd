----------------------------------------------------------------------------------
-- Create Date: 09.10.2026 12:49:55
-- Design Name: johnson_wrapper
-- Module Name: johnson_wrapper - Behavioral
-- Project Name: Johnson Counter
-- Target Devices: Basys3 with Artix7
-- Tool Versions: Vivado 2022.2
-- Description: 
-- Module that connects together:
-- clk_divider
-- debounce
-- johnson
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity johnson_wrapper is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           led_o : out STD_LOGIC_VECTOR (3 downto 0));
end johnson_wrapper;

architecture Behavioral of johnson_wrapper is
    -- components
    component johnson 
        Port ( clk_i : in STD_LOGIC;
               rst_i : in STD_LOGIC;
               led_o : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component clk_divider 
        Generic (OUTPUT_FREQ_HZ : positive;
                 INPUT_FREQ_HZ : positive);
        Port ( f_100MHz_i : in std_logic; -- input clock
               rst_i     : in std_logic; -- asynchronous reset input
               f_o   : out std_logic); -- output divided clock    
    end component;
    
    component debounce
        port ( clk_i : in std_logic;
               key_in : in std_logic; -- direct signal from the button
               key_out : out std_logic); -- output signal after debouncing
    end component;
    
    -- signals
    signal clk : std_logic;
    signal rst : std_logic;
begin
    debounce_module: debounce
        Port map ( clk_i => clk_i,
                   key_in => rst_i,
                   key_out => rst 
                  );
    
    clk_divder_module: clk_divider
        Generic map (OUTPUT_FREQ_HZ => 1000000,
                     INPUT_FREQ_HZ => 100_000_000)
        Port map ( f_100MHz_i => clk_i,
                   rst_i      => rst,
                   f_o        => clk);
    
    johnson_module: johnson
        Port map ( clk_i => clk,
                   rst_i => rst,
                   led_o => led_o);
end Behavioral;
