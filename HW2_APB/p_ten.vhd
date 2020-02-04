----------------------------------------------------------------------------------
-- Company: 
-- Engineer: April Bell
-- 
-- Create Date: 02/02/2020 07:58:32 PM
-- Design Name: P10
-- Module Name: p_ten - Behavioral
-- Project Name: S-DES
-- Target Devices: Nexys 4
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity p_ten is
    Port ( key_ten : in STD_LOGIC_VECTOR (9 downto 0);
           ls1 : out STD_LOGIC_VECTOR (4 downto 0);
           rs1 : out STD_LOGIC_VECTOR (4 downto 0));
end p_ten;

architecture Behavioral of p_ten is

begin

ls1(4) <= key_ten(2);
ls1(3) <= key_ten(4);
ls1(2) <= key_ten(1);
ls1(1) <= key_ten(6);
ls1(0) <= key_ten(3);
rs1(4) <= key_ten(9);
rs1(3) <= key_ten(0);
rs1(2) <= key_ten(8);
rs1(1) <= key_ten(7);
rs1(0) <= key_ten(5);

end Behavioral;
