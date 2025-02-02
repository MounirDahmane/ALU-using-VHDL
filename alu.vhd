-----------------Implementation-of-ALU------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

--------------------------------------------------

ENTITY alu is

	GENERIC( N : INTEGER := 2 );
Port(

	inp_1  : IN  STD_LOGIC_VECTOR(N-1 downto 0);
	inp_2  : IN  STD_LOGIC_VECTOR(N-1 downto 0);
	Cin    : IN  STD_LOGIC;
	opcode : IN  STD_LOGIC_VECTOR(3 downto 0);
	output : OUT STD_LOGIC_VECTOR(N downto 0)
	
);
End ENTITY;

--------------------------------------------------

ARCHITECTURE alu of alu is

SIGNAL y_unsig     : STD_LOGIC_VECTOR(N-1 downto 0);
SIGNAL y_sig       : SIGNED(N downto 0);
SIGNAL inp1_sig    : SIGNED(N downto 0);
SIGNAL inp2_sig    : SIGNED(N downto 0);
SIGNAL Cin_sig     : INTEGER RANGE 0 to 1;
SIGNAL Cout        : std_LOGIC;
BEGIN
--------------------LOGIC-------------------------

with opcode(2 downto 0) select

	y_unsig <= NOT inp_1 		  when "000",
			   NOT inp_2          when "001",
			   (inp_1 AND  inp_2) when "010",
			   (inp_1 OR   inp_2) when "011",
			   (inp_1 NAND inp_2) when "100",
			   (inp_1 NOR  inp_2) when "101",
			   (inp_1 XOR  inp_2) when "110",
			   (inp_1 XNOR inp_2) when OTHERS;
				  
------------------ARITHMETIC----------------------

inp1_sig <= '0' & signed(inp_1);
inp2_sig <= '0' & signed(inp_2);
Cin_sig  <= 1 when Cin = '1' ELSE 0;

with opcode(2 downto 0) select

	y_sig <= inp1_sig 		     when "000",
			 inp2_sig            when "001",
			 inp1_sig + 1        when "010",
			 inp2_sig + 1        when "011",
			 inp1_sig - 1        when "100",
			 inp2_sig - 1        when "101",
			 inp1_sig + inp2_sig when "110",
			 inp1_sig + inp2_sig + Cin_sig when OTHERS;

output(N downto 0) <= STD_LOGIC_VECTOR(y_sig) when opcode(3) = '1' ELSE '0' & y_unsig;

END alu;






