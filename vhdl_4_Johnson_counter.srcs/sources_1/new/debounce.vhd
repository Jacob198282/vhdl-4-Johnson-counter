----------------------------------------------------------------------------------
-- Create Date: 09.10.2026 14:48:08
-- Design Name: debounce
-- Module Name: debounce - Behavioral
-- Project Name: debounce
-- Tool Versions: Vivado 2022.2
-- Description: 
-- Debouncing module for buttons
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce is
    port ( clk_i : in std_logic;
           key_in : in std_logic; -- direct signal from the button
           key_out : out std_logic); -- output signal after debouncing
end debounce;

architecture Behavioral of debounce is         
    signal q : std_logic := '0';
    signal key_synch : std_logic := '0';
    signal key_stable_out : std_logic := '0';   -- stable output signal assigned to key_out
    constant delay_const : integer := 10000;  -- delay of the stable signal
begin
-- example of process that implements two synchronizing flip-flops
-- and debouncing circuit   
    synch: process (clk_i) is
    variable delay_cntr : integer := 0;
    begin
      if rising_edge(clk_i) then
        q <= key_in;
        key_synch <= q;
        if (key_synch = key_stable_out) then
          delay_cntr := 0;
        else
          delay_cntr := delay_cntr + 1;
        end if;
        if (delay_cntr = delay_const) then
          key_stable_out <= key_synch;
          delay_cntr := 0;
        end if;
      end if;
    end process;
    
    key_out <= key_stable_out;

end Behavioral;
