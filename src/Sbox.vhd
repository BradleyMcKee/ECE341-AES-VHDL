library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
 
entity sbox is
	port(
	clk: in std_logic;
	dataIN: in std_logic_vector(31 downto 0); 
	
	byteLUT: out std_logic_vector(31 downto 0));
end entity;

architecture sample of sbox is
type LUT is array(255 downto 0) of std_logic_vector (7 downto 0);	  
--signal temp: std_logic_vector (7 downto 0);
constant sboxLUT: LUT :=
(
x"16", x"bb", x"54", x"b0", x"0f", x"2d", x"99", x"41", x"68", x"42", x"e6", x"bf", x"0d", x"89", x"a1", x"8c", 
x"df", x"28", x"55", x"ce", x"e9", x"87", x"1e", x"9b", x"94", x"8e", x"d9", x"69", x"11", x"98", x"f8", x"e1", 
x"9e", x"1d", x"c1", x"86", x"b9", x"57", x"35", x"61", x"0e", x"f6", x"03", x"48", x"66", x"b5", x"3e", x"70", 
x"8a", x"8b", x"bd", x"4b", x"1f", x"74", x"dd", x"e8", x"c6", x"b4", x"a6", x"1c", x"2e", x"25", x"78", x"ba", 
x"08", x"ae", x"7a", x"65", x"ea", x"f4", x"56", x"6c", x"a9", x"4e", x"d5", x"8d", x"6d", x"37", x"c8", x"e7", 
x"79", x"e4", x"95", x"91", x"62", x"ac", x"d3", x"c2", x"5c", x"24", x"06", x"49", x"0a", x"3a", x"32", x"e0", 
x"db", x"0b", x"5e", x"de", x"14", x"b8", x"ee", x"46", x"88", x"90", x"2a", x"22", x"dc", x"4f", x"81", x"60", 
x"73", x"19", x"5d", x"64", x"3d", x"7e", x"a7", x"c4", x"17", x"44", x"97", x"5f", x"ec", x"13", x"0c", x"cd", 
x"d2", x"f3", x"ff", x"10", x"21", x"da", x"b6", x"bc", x"f5", x"38", x"9d", x"92", x"8f", x"40", x"a3", x"51", 
x"a8", x"9f", x"3c", x"50", x"7f", x"02", x"f9", x"45", x"85", x"33", x"4d", x"43", x"fb", x"aa", x"ef", x"d0", 
x"cf", x"58", x"4c", x"4a", x"39", x"be", x"cb", x"6a", x"5b", x"b1", x"fc", x"20", x"ed", x"00", x"d1", x"53", 
x"84", x"2f", x"e3", x"29", x"b3", x"d6", x"3b", x"52", x"a0", x"5a", x"6e", x"1b", x"1a", x"2c", x"83", x"09", 
x"75", x"b2", x"27", x"eb", x"e2", x"80", x"12", x"07", x"9a", x"05", x"96", x"18", x"c3", x"23", x"c7", x"04", 
x"15", x"31", x"d8", x"71", x"f1", x"e5", x"a5", x"34", x"cc", x"f7", x"3f", x"36", x"26", x"93", x"fd", x"b7", 
x"c0", x"72", x"a4", x"9c", x"af", x"a2", x"d4", x"ad", x"f0", x"47", x"59", x"fa", x"7d", x"c9", x"82", x"ca", 
x"76", x"ab", x"d7", x"fe", x"2b", x"67", x"01", x"30", x"c5", x"6f", x"6b", x"f2", x"7b", x"77", x"7c", x"63" 
);
constant invSboxLUT: LUT :=
(
x"7d", x"0c", x"21", x"55", x"63", x"14", x"69", x"e1", x"26", x"d6", x"77", x"ba", x"7e", x"04", x"2b", x"17",
x"61", x"99", x"53", x"83", x"3c", x"bb", x"eb", x"c8", x"b0", x"f5", x"2a", x"ae", x"4d", x"3b", x"e0", x"a0",
x"ef", x"9c", x"c9", x"93", x"9f", x"7a", x"e5", x"2d", x"0d", x"4a", x"b5", x"19", x"a9", x"7f", x"51", x"60",
x"5f", x"ec", x"80", x"27", x"59", x"10", x"12", x"b1", x"31", x"c7", x"07", x"88", x"33", x"a8", x"dd", x"1f",
x"f4", x"5a", x"cd", x"78", x"fe", x"c0", x"db", x"9a", x"20", x"79", x"d2", x"c6", x"4b", x"3e", x"56", x"fc",
x"1b", x"be", x"18", x"aa", x"0e", x"62", x"b7", x"6f", x"89", x"c5", x"29", x"1d", x"71", x"1a", x"f1", x"47",
x"6e", x"df", x"75", x"1c", x"e8", x"37", x"f9", x"e2", x"85", x"35", x"ad", x"e7", x"22", x"74", x"ac", x"96",
x"73", x"e6", x"b4", x"f0", x"ce", x"cf", x"f2", x"97", x"ea", x"dc", x"67", x"4f", x"41", x"11", x"91", x"3a",
x"6b", x"8a", x"13", x"01", x"03", x"bd", x"af", x"c1", x"02", x"0f", x"3f", x"ca", x"8f", x"1e", x"2c", x"d0",
x"06", x"45", x"b3", x"b8", x"05", x"58", x"e4", x"f7", x"0a", x"d3", x"bc", x"8c", x"00", x"ab", x"d8", x"90",
x"84", x"9d", x"8d", x"a7", x"57", x"46", x"15", x"5e", x"da", x"b9", x"ed", x"fd", x"50", x"48", x"70", x"6c",
x"92", x"b6", x"65", x"5d", x"cc", x"5c", x"a4", x"d4", x"16", x"98", x"68", x"86", x"64", x"f6", x"f8", x"72",
x"25", x"d1", x"8b", x"6d", x"49", x"a2", x"5b", x"76", x"b2", x"24", x"d9", x"28", x"66", x"a1", x"2e", x"08",
x"4e", x"c3", x"fa", x"42", x"0b", x"95", x"4c", x"ee", x"3d", x"23", x"c2", x"a6", x"32", x"94", x"7b", x"54",
x"cb", x"e9", x"de", x"c4", x"44", x"43", x"8e", x"34", x"87", x"ff", x"2f", x"9b", x"82", x"39", x"e3", x"7c",
x"fb", x"d7", x"f3", x"81", x"9e", x"a3", x"40", x"bf", x"38", x"a5", x"36", x"30", x"d5", x"6a", x"09", x"52"
);
begin	
	process(dataIN)   
	variable x : integer:= 0;	
	variable y : integer:= 7;
	begin  
	
    for i in 0 to 3 loop
	byteLUT(y downto x) <= sboxLUT(to_integer(unsigned(dataIN(y downto x)))); --NEED WAIT STATEMENT
	wait;
	x:=x+8;
	y:=y+8;	 
	end loop;
	end process;

end architecture;