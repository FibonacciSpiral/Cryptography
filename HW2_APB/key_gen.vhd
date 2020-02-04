----------------------------------------------------------------------------------
-- Company: 
-- Engineer: April Bell
-- 
-- Create Date: 02/03/2020 11:06:31 AM
-- Design Name: S-DES Key Generator
-- Module Name: key_gen - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity key_gen is
    Port ( key10 : in STD_LOGIC_VECTOR (9 downto 0);
--           out10 : out STD_LOGIC_VECTOR (9 downto 0)
           key1 : out STD_LOGIC_VECTOR (7 downto 0);
           key2 : out STD_LOGIC_VECTOR (7 downto 0)
           );
end key_gen;

architecture Behavioral of key_gen is
    COMPONENT p_ten
    PORT(
          key_ten : IN STD_LOGIC_VECTOR (9 downto 0);
          ls1, rs1 : OUT STD_LOGIC_VECTOR (4 downto 0)
          );
    END COMPONENT;
    
    COMPONENT p_eight is
        Port ( 
           ls, rs : in STD_LOGIC_VECTOR (4 downto 0);
           p8 : out STD_LOGIC_VECTOR (7 downto 0)
           ); 
           
    END COMPONENT;

signal ls1w, rs1w : STD_LOGIC_VECTOR (4 downto 0);
signal ls2w, rs2w : STD_LOGIC_VECTOR (4 downto 0);
signal ls3w, rs3w : STD_LOGIC_VECTOR (4 downto 0);

begin

Inst_p_ten: p_ten PORT MAP(
            key_ten => key10,
            ls1 => ls1w,
            rs1 => rs1w
);

--out10(9) <= ls2w(4);
--out10(8) <= ls2w(3);
--out10(7) <= ls2w(2);
--out10(6) <= ls2w(1);
--out10(5) <= ls2w(0);
--out10(4) <= rs2w(4);
--out10(3) <= rs2w(3);
--out10(2) <= rs2w(2);
--out10(1) <= rs2w(1);
--out10(0) <= rs2w(0);

ls2w <= STD_LOGIC_VECTOR(rotate_left(UNSIGNED(ls1w), 1)); --left rotate 1
rs2w <= STD_LOGIC_VECTOR(rotate_left(UNSIGNED(rs1w), 1));


Inst_p_eight1: p_eight PORT MAP(
            ls => ls2w,
            rs => rs2w,
            p8 => key1
);

ls3w <= STD_LOGIC_VECTOR(rotate_left(UNSIGNED(ls2w), 2)); --left rotate 2
rs3w <= STD_LOGIC_VECTOR(rotate_left(UNSIGNED(rs2w), 2));

Inst_p_eight2: p_eight PORT MAP(
            ls => ls3w,
            rs => rs3w,
            p8 => key2
);

end Behavioral;
