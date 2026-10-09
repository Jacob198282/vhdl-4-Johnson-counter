----------------------------------------------------------------------------------
-- Create Date: 02.10.2026 16:12:40
-- Design Name: johnson
-- Module Name: johnson - Behavioral
-- Project Name: Johnson Counter
-- Target Devices: Basys3 with Artix7
-- Tool Versions: Vivado 2022.2
-- 
-- Description: 
-- Simple Johnson counter whose output is sent to LEDs on the Basys3 board
-- 
-- States:
-- 0 0 0 0
-- 1 0 0 0
-- 1 1 0 0
-- 1 1 1 0
-- 1 1 1 1
-- 0 1 1 1
-- 0 0 1 1
-- 0 0 0 1
-- 0 0 0 0
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity johnson is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           led_o : out STD_LOGIC_VECTOR (3 downto 0));
end johnson;

architecture Behavioral of johnson is
    -- enumeration type
    -- for FSM which determines the output of the counter
    type COUNT_STATES is (START, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN);
    -- signals
    signal curr_state : COUNT_STATES; -- for counting on rising edge of the clock
    SIGNAL next_state : COUNT_STATES;
    signal count_out : std_logic_vector (3 downto 0) := (others => '0'); -- output of the counter, assigned to led_o
begin
    -- sequential fsm process with asychronous reset
    clock: process (clk_i, rst_i) is
    begin
        if rst_i = '1' then
            curr_state <= START;
        elsif rising_edge (clk_i) then
            curr_state <= next_state;
        end if;
    end process clock;

    -- counter combinational fsm process
    johnson_fsm: process (curr_state, next_state, count_out) is
    begin
        next_state <= curr_state;
        case curr_state is
            when START =>
                count_out <= "0000";
                next_state <= ONE;
            when ONE =>
                count_out <= "1000";
                next_state <= TWO;
            when TWO =>
                count_out <= "1100";
                next_state <= THREE;
            when THREE =>
                count_out <= "1110";
                next_state <= FOUR;
            when FOUR =>
                count_out <= "1111";
                next_state <= FIVE;
            when FIVE =>
                count_out <= "0111";
                next_state <= SIX;
            when SIX =>
                count_out <= "0011";
                next_state <= SEVEN;
            when SEVEN =>
                count_out <= "0001";
                next_state <= START;
            when others =>
                next_state <= START;
        end case;
    end process johnson_fsm;
    
    -- constant assignment to output
    led_o <= count_out;
end Behavioral;
