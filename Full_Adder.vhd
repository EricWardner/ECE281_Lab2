----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering USAF Academy
-- Engineer: C3C Eric J Wardner
-- 
-- Create Date:    22:52:00 02/09/2014 
-- Design Name:     Lab2 Prelab
-- Module Name:    Full_Adder - Behavioral 
-- Project Name:    Lab 2
-- Target Devices: Sparten FPGA
-- Tool versions: 
-- Description:  Full Adder with carry output
--
-- Dependencies: 
--
-- Revision: 1
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

entity Full_Adder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end Full_Adder;

architecture Behavioral of Full_Adder is

signal BC, AB, AC : STD_Logic;

begin
BC <= B and Cin;
AB <= A and B;
AC <= A and Cin;

Sum <= A xor B xor Cin;
Cout <= BC or AB or AC;


end Behavioral;

