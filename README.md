# 4 Bit Johnson Counter

4 Bit Johnson Counter is a project written in Vivado using VHDL language. It is created to work with Basys3 board. You can check information about this board [here](https://digilent.com/reference/programmable-logic/basys-3/start).

On every rising edge of the divided clock Johnson's counter value increases by one. The counter sequences are:
```
0 0 0 0
1 0 0 0
1 1 0 0
1 1 1 0
1 1 1 1
0 1 1 1
0 0 1 1
0 0 0 1
0 0 0 0
```

## How it works
### Hierarchy
Hierarchy of this project is as follows:
<img width="967" height="302" alt="hierarchy" src="https://github.com/user-attachments/assets/77073ccc-d8fb-4621-8cb8-7692fb462510" />

### johnson_wrapper module
Ports of this module:
```vhdl
entity gray_count is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           led_o : out STD_LOGIC_VECTOR (3 downto 0));
end gray_count;
```
`clk_i` is connected to internal 100 MHz clock

`rst_i` is connected to BTNR (right) button on the board and acts as asynchronous reset

`led_o` is output of the Gray counter and is connected to diodes on the board:
+ LD0 diode - 0 bit of Johnson counter (`led_o(0)`),
+ LD1 diode - 1 bit of Johnson counter (`led_o(1)`),
+ LD2 diode - 2 bit of Johnson counter (`led_o(2)`).
+ LD3 diode - 3 bit of Johnson counter (`led_o(3)`).

By clicking on the mechanical button a clock signal is generated. Counter is counting on every rising edge of the clock signal.

### debounce module
Module used for elimination of bouncing of the reset button.
Ports of this module:
```vhdl
entity debounce is
    port ( clk_i : in std_logic;
           key_in : in std_logic; -- direct signal from the button
           key_out : out std_logic); -- output signal after debouncing
end debounce;
```
### clk_divider module
Clock divider from internal 100 MHz (or any other frequency specified by overriding `INPUT_FREQ_HZ` generic) to desired even frequency.
Ports of this module:
```vhdl
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
```
### johnson module
Main module responsible for counting in Johnson's code.
Ports of this module:
```vhdl
entity johnson is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           led_o : out STD_LOGIC_VECTOR (3 downto 0));
end johnson;
```

## Video presentation

## Installation and implementation
Installation guide is based on [adiuvoengineering.com](https://www.adiuvoengineering.com/post/microzed-chronicles-working-with-vivado-and-git) guide.

1. Clone the repository.
2. Open the project (xpr file) using Vivado.
3. The project should load within couple of minutes.
4. Run Synthesis.
<img width="229" height="91" alt="obraz" src="https://github.com/user-attachments/assets/5e94d57d-8fec-42e9-a58f-3c1b74a9c034" />

5. After successful synthesis Run Implementation.
<img width="227" height="95" alt="obraz" src="https://github.com/user-attachments/assets/046e6cd6-eb29-4ac6-9f6f-9143e0cca6ca" />

6. After successful implementation Generate Bitstream.
<img width="229" height="69" alt="obraz" src="https://github.com/user-attachments/assets/7c5e1884-6e2e-4db1-ad45-a97d21be818e" />

7. Make sure that jumper on the Basys3 board is switched to power from USB, as pictured in the photo below.


Plug in Basys3 board to the computer.

8. Open Hardware Manager and load the project to the board.
<img width="281" height="57" alt="obraz" src="https://github.com/user-attachments/assets/2e8efc15-c0a0-4281-9e45-c479b1681d9a" />


## Requirements
1. Computer with Windows or Linux (I was using Windows).
2. Vivado 2022.2 or newer (project was made using this version of Vivado). Keep in mind that version 2024 had some trouble with Basys3 boards.
3. Basys3 board.
4. MicroUSB cable that can transmit data.
