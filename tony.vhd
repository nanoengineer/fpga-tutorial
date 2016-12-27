--------------------------------------------------------
--	CPEN 311 - Lab 1
--	Graeme Rennie	23071137
--	Derek Chan 		33184128
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tony is
   port (KEY: in std_logic_vector(3 downto 0);  -- push-button switches
         SW : in std_logic_vector(17 downto 0);  -- slider switches
         CLOCK_50: in std_logic;                 -- 50MHz clock input
         CLOCK_27 : in std_logic;
         LEDR : out std_logic_vector(17 downto 0);
	 HEX0 : out std_logic_vector(6 downto 0); -- output to drive digit 0
	 HEX1 : out std_logic_vector(6 downto 0)
   );     
end tony;

architecture structural of tony is


begin
	
	--hex0 <= SW(6 downto 0);
	--hex1 <= SW(13 downto 7);
	process (all)
	begin
	
	case SW(3 downto 0) is
		when "0000" =>
			hex0 <= "1000000";
		when "0001" =>
			hex0 <= "1111001";
		when "0010" =>
			hex0 <= "0100100";
		when "0011" =>
			hex0 <= "0110000";
		when "0100" =>
			hex0 <= "0011001";
		when "0101" =>
			hex0 <= "0010010";
		when "0110" =>
			hex0 <= "0000010";
		when "0111" =>
			hex0 <= "1111000";
		when "1000" =>
			hex0 <= "0000000";
		when "1001" =>
			hex0 <= "0010000";
		when others =>
			hex0 <= "1111111";

	end case;
	end process;
	
	LEDR <= SW(17 downto 0);
	
end structural;
