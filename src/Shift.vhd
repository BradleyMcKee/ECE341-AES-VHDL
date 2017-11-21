library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity shift is
	port(
	dataIN:in std_logic_vector(127 downto 0);
	
	dataOUT:out std_logic_vector(127 downto 0));
end entity;

architecture SampleShiftRow of shift is
begin
	process	 
	variable temp: std_logic_vector(127 downto 0);
		begin
		--ROW 1 (UNCHANGED)	//a(0,0) a(0,1) a(0,2) a(0,3)
		temp(127 downto 120) := dataIN(127 downto 120);
		temp(95 downto 88) := dataIN(95 downto 88);
		temp(63 downto 56) := dataIN(63 downto 56);
		temp(31 downto 24) := dataIN(31 downto 24);
		--ROW 2 (1 BYTE SHIFT LEFT)
		--a(1,0) a(1,1) a(1,2) a(1,3)
		--a(1,1) a(1,2) a(1,3) a(1,0)
		temp(119 downto 112) := dataIn(87 downto 80);
		temp(87 downto 80) := dataIn(55 downto 48);
		temp(55 downto 48) := dataIn(23 downto 16);
		temp(23 downto 16) := dataIn(119 downto 112);
		--ROW 3	(2 BYTE SHIFT LEFT) 
		--a(2,0) a(2,1) a(2,2) a(2,3)
		--a(2,2) a(2,3) a(2,0) a(2,1)
		temp(111 downto 104) := dataIn(47 downto 40);
		temp(79 downto 72) := dataIn(15 downto 8);
		temp(47 downto 40) := dataIn(111 downto 104);
		temp(15 downto 8) := dataIn(79 downto 72);
		--ROW 4	(3 BYTE SHIFT LEFT) 
		--a(3,0) a(3,1) a(3,2) a(3,3)
		--a(3,3) a(3,0) a(3,1) a(3,2)
		temp(103 downto 96) := dataIn(7 downto 0);
		temp(71 downto 64) := dataIn(103 downto 96);
		temp(39 downto 32) := dataIn(71 downto 64);
		temp(7 downto 0) := dataIn(39 downto 32);
		
		dataOUT <= temp;
	
		end process;
end architecture;