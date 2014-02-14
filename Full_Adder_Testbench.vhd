-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  USE ieee.std_logic_unsigned.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT Full_Adder
          PORT(
                  A: IN std_logic_vector(3 downto 0);
                  B: IN std_logic_vector(3 downto 0);
						SubSwitch : IN std_logic;						
                  Sum : OUT std_logic_vector(3 downto 0);
						Overflow : OUT std_logic
                  );
          END COMPONENT;

          SIGNAL SubSwitch, Overflow : STD_LOGIC;
			 SIGNAL A, B, Sum : std_logic_vector(3 downto 0);
          

  BEGIN

  -- Component Instantiation
          uut: Full_Adder PORT MAP(
                  A => A,
                  B => B,
						SubSwitch => SubSwitch,
						Sum => Sum,
						Overflow => Overflow						
          );


  --  Test Bench Statements
     tb : PROCESS
     BEGIN
	  
	  A <= "0000";
	  B <= "0000";
	  SubSwitch <= '0';
	  
	  for i in 0 to 15 loop
			
			for j in 0 to 15 loop

				wait for 10 ns; 
					
					assert(Sum = A+B) report "Expected Sum =  "& integer'image(to_integer(unsigned((A)))) & " + " & integer'image(to_integer(unsigned((B)))) & " = "& integer'image(to_integer(unsigned((A+B))))&
					"Actual Sum: " & integer'image(to_integer(unsigned(Sum))) severity ERROR;
					
					assert(Sum = A*B) report "A + B = " & integer'image(to_integer(unsigned((A)))) & " + " & integer'image(to_integer(unsigned((B)))) & " = " & integer'image(to_integer(unsigned(Sum))) & " CORRECT!!" severity note;
					
					B <= B + "0001";
			end loop;
			
			A <= A + "0001";
		end loop;

        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
