----------------------------------------------------------------------------------
-- Create Date: 07.10.2026 08:52:41
-- Design Name: johnson 
-- Module Name: clk_divider - Behavioral
-- Project Name: Johnson Counter
-- Tool Versions: Vivado 2022.2
-- Target Devices: Basys3 with Artix7
-- Description: 
-- Divides the input clock to disired frequency 
-- Works only for even output frequencies
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_divider is
    Generic (
        OUTPUT_FREQ_HZ : positive := 1;
        INPUT_FREQ_HZ : positive := 100_000_000
    );
    Port (
        f_100MHz_i : in std_logic; -- input clock
        rst_i     : in std_logic; -- asynchronous reset input
        f_o   : out std_logic -- output divided clock    
    );
end clk_divider;

architecture Behavioral of clk_divider is
    signal counter : integer := 0;
    signal tmp     : std_logic := '0';
--    signal counter : std_logic_vector  (6 downto 0);
    constant HALF_PERIOD : positive := INPUT_FREQ_HZ / (2*OUTPUT_FREQ_HZ);
begin
    divider: process (f_100MHz_i, rst_i)
    begin
        if rst_i='1' then
            counter <= 0;
            tmp <= '0';
        elsif rising_edge(f_100MHz_i) then
            counter <= counter + 1;
            if counter = HALF_PERIOD - 1 then
                tmp <= not tmp;
                counter <= 0;
            end if;
        end if;
    end process divider;
    f_o <= tmp;
end Behavioral;
