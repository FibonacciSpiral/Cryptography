----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/03/2020 11:04:04 AM
-- Design Name: 
-- Module Name: p_eight - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity p_eight is
    Port ( ls : in STD_LOGIC_VECTOR (4 downto 0);
           rs : in STD_LOGIC_VECTOR (4 downto 0);
           p8 : out STD_LOGIC_VECTOR (7 downto 0));
end p_eight;

architecture Behavioral of p_eight is

begin

p8(7) <= rs(4); --6
p8(6) <= ls(2); --3
p8(5) <= rs(3); --7
p8(4) <= ls(1); --4
p8(3) <= rs(2); --8
p8(2) <= ls(0); --5
p8(1) <= rs(0); --10
p8(0) <= rs(1); --9

end Behavioral;
