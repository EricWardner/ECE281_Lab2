----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering USAF Academy
-- Engineer: C3C Eric J. Wardner
-- 
-- Create Date:    22:52:00 02/09/2014 
-- Design Name: 	 4 Bit Full Adder with Carry
-- Module Name:    Single_Bit_Adder - Component 
-- Project Name: 	Lab 2
-- Target Devices: Spartan 3 FPGA
-- Tool versions: 
-- Description: Will implement a 4 bit adder with carry and overflow
--
-- Dependencies: 
--
-- Revision: 1.1
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Single_Bit_Adder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end Single_Bit_Adder;

architecture Behavioral of Single_Bit_Adder is

begin

Sum <= A xor B xor Cin;
Cout <= (B and Cin) or (A and B) or (A and Cin);


end Behavioral;

