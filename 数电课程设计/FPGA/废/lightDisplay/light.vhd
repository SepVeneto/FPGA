library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity light is
	generic(t : integer:= 1;
		      nsGewR : integer:= 0;		--状态变量
		      nsYewR : integer:= 1;
		      nsRewG : integer:= 2;
			 nsRewY : integer:= 3 );
	port( stateQ : in std_logic_vector(1 downto 0);
		 CLK : in std_logic;
		 nsR, nsY, nsG, ewR, ewY, ewG : out std_logic);
end entity;

architecture beh of light is
begin
	process(stateQ, CLK)
	variable num : std_logic_vector(1 downto 0);
	variable tempLight : std_logic_vector(5 downto 0);
	begin
		num := stateQ;
		if( rising_edge(CLK) ) then
			if( num = "00" ) then
				tempLight := "001100";
			elsif( num = "01" ) then
				tempLight := "010100";
			elsif( num = "10" ) then
				tempLight := "100001";
			elsif( num = "11" ) then
				tempLight := "100010";
			end if;
		end if;
		nsR <= tempLight(5);
		nsY <= tempLight(4);
		nsG <= tempLight(3);
		ewR <= tempLight(2);
		ewY <= tempLight(1);
		ewG <= tempLight(0);
		if( tempLight(1) = '1' ) then
			if( CLK = '1' ) then
				ewY <= '1';
			elsif( CLK = '0' ) then
				ewY <= '0';
			end if;
		end if;
		if( tempLight(4) = '1' ) then
			if( CLK = '1' ) then
				nsY <= '1';
			elsif( CLK = '0' ) then
				nsY <= '0';
			end if;
		end if;
	end process;
end architecture;
				
