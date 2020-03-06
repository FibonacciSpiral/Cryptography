----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/10/2020 10:58:38 AM
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0)
           );

end top_level;

architecture Behavioral of top_level is

    COMPONENT caeser is 
    PORT(
        key, plain : in STD_LOGIC_VECTOR(4 downto 0);
        cipher : out STD_LOGIC_VECTOR(4 downto 0)
        );
    END COMPONENT;


signal key_in : STD_LOGIC_VECTOR (4 downto 0);
signal ciphout, ptin : STD_LOGIC_VECTOR (4 downto 0);

begin

key_in <= sw(15 downto 11);

ptin <= sw(4 downto 0);

led(4 downto 0) <= ciphout(4 downto 0);
led(15 downto 11) <= key_in(4 downto 0);
led(10 downto 6) <= ptin(4 downto 0);

Inst_caeser: caeser PORT MAP(
            key => key_in,
            plain => ptin,
            cipher => ciphout
);     

end Behavioral;
