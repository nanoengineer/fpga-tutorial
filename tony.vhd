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
	 HEX1 : out std_logic_vector(6 downto 0);
	 HEX2 : out std_logic_vector(6 downto 0)
   );     
end tony;

architecture structural of tony is

signal switch_input : std_logic_vector(7 downto 0);

signal digit_0 : std_logic_vector(3 downto 0);
signal digit_1 : std_logic_vector(3 downto 0);
signal digit_2 : std_logic_vector(3 downto 0);

signal next_state : std_logic_vector (1 downto 0) := "00" ;
signal current_state : std_logic_vector (1 downto 0) := "00" ;

signal number_1 : unsigned(7 downto 0) := "00000000";
signal number_2 : unsigned(7 downto 0) := "00000000";
signal result : unsigned(7 downto 0) := "00000000";

   component hex_to_7seg
   port (HEX_IN : in std_logic_vector(3 downto 0);  -- Switch input for hex value
         SEG_OUT : out std_logic_vector(6 downto 0)  -- LED output (7 seg)
   );
   end component;
	
begin
	
	next_state_logic : process(all)
	begin
		case current_state is
			when "00" =>
			next_state <= "01";
			when "01" =>
			next_state <= "10";
			when "10" =>
			next_state <= "00";
			when others =>
			next_state <= "00";
		end case;
	end process;
	
	next_state_switch : process(SW(17))
	begin
		if KEY(1) = '0' then
			current_state <= "00";
		elsif rising_edge(SW(17)) then
			current_state <= next_state;
		end if;	
	end process;
	
	switch_input <= SW(7 downto 0);
	
	store_number : process (SW(17))
	begin
		if (rising_edge(SW(17))) then 
			case current_state is
				when "00" =>
				number_1 <= UNSIGNED(switch_input);
				when "01" =>
				number_2 <= UNSIGNED(switch_input);
				when others =>
			end case;
		end if;
	end process;
	
	accumulator : process (all)
	begin
		if SW(16) = '1' then
		result <= number_1 + number_2;
		else
		result <= number_1 - number_2;
		end if;
	end process;
	
	
	
	display_values : process (all)
	variable input_value : UNSIGNED(7 downto 0) := "00000000";
	begin
		case current_state is 
			when "00" =>
			input_value := UNSIGNED(switch_input);
			when "01" =>
			input_value := UNSIGNED(switch_input);
			when "10" => 
			input_value := UNSIGNED(result);
			when others =>
			input_value := "00000000";
		end case;
				
		digit_0 <= STD_logic_vector(input_value mod(10))(3 downto 0);
		input_value := input_value/10;
		digit_1 <= STD_logic_vector(input_value mod(10))(3 downto 0);
		input_value := input_value/10;
		digit_2 <= STD_logic_vector(input_value mod(10))(3 downto 0);
		
	end process;
	
	u0: hex_to_7seg port map(digit_0,HEX0);
	u1: hex_to_7seg port map(digit_1,HEX1);
	u2: hex_to_7seg port map(digit_2,HEX2);
	
	LEDR(1 downto 0) <= current_state;
	
end structural;
