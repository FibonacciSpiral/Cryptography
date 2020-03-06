----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2020 06:46:45 PM
-- Design Name: 
-- Module Name: caeser - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity caeser is
    Port ( key : in STD_LOGIC_VECTOR (4 downto 0);
           plain : in STD_LOGIC_VECTOR (4 downto 0);
           cipher : out STD_LOGIC_VECTOR (4 downto 0));
end caeser;

architecture Behavioral of caeser is

signal int_pt, int_key, int_cip : integer;
signal test_in : STD_LOGIC_VECTOR (4 downto 0);

begin

int_pt <= to_integer(unsigned(plain));
int_key <= to_integer(unsigned(key));

int_cip <= (int_pt + int_key) MOD 26;

cipher <= STD_LOGIC_VECTOR(to_unsigned(int_cip, cipher'length));

end Behavioral;
