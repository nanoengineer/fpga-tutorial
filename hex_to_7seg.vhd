library ieee;
use ieee.std_logic_1164.all;

entity hex_to_7seg is
   port (HEX_IN : in std_logic_vector(3 downto 0);  -- Switch input for hex value
         SEG_OUT : out std_logic_vector(6 downto 0)  -- LED output (7 seg)
   );
end hex_to_7seg;


architecture behavioural of hex_to_7seg is
begin 

process (all)
	begin
	
	case HEX_IN is
		when "0000" =>
			SEG_OUT <= "1000000";
		when "0001" =>
			SEG_OUT <= "1111001";
		when "0010" =>
			SEG_OUT <= "0100100";
		when "0011" =>
			SEG_OUT <= "0110000";
		when "0100" =>
			SEG_OUT <= "0011001";
		when "0101" =>
			SEG_OUT <= "0010010";
		when "0110" =>
			SEG_OUT <= "0000010";
		when "0111" =>
			SEG_OUT <= "1111000";
		when "1000" =>
			SEG_OUT <= "0000000";
		when "1001" =>
			SEG_OUT <= "0010000";
		when others =>
			SEG_OUT <= "1111111";

	end case;
	end process;
	
end behavioural;

