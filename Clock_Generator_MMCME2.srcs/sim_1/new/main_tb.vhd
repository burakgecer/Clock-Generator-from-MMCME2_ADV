
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity main_tb is
end main_tb;

architecture Behavioral of main_tb is
    constant CLOCK_TIME : time := 10 ns;
    signal clk_100   : std_logic := '0';
    signal CLKOUT1   : STD_LOGIC ;
    signal CLKOUT2   : STD_LOGIC ;
    signal LOCKED : std_logic := '0';
    signal rst    : STD_LOGIC := '0';
    signal CLKOUT1_AND : STD_LOGIC := '0';
    signal CLKOUT2_AND : STD_LOGIC := '0';
    
    component main
        Port ( clk_100 : in STD_LOGIC;
              CLKOUT1  : out STD_LOGIC;
              CLKOUT2  : out STD_LOGIC;
              LOCKED   : out STD_LOGIC;
              rst      : in STD_LOGIC
              );

    end component;
begin
    clk_100_process: process
    begin
        while now < 1000 ns loop
            clk_100 <= '0';
            wait for CLOCK_TIME/2;
            clk_100 <= '1';
            wait for CLOCK_TIME/2;
            clk_100 <= not clk_100 after CLOCK_TIME/2;
        end loop;
        wait;
    end process;


    uut: main port map (
        clk_100 => clk_100,
        CLKOUT1 => CLKOUT1,
        CLKOUT2 => CLKOUT2,
        LOCKED  => LOCKED,
        rst     => rst
        
    );
    -- Process to update new_clk based on LOCKED and CLKOUT1
    process (LOCKED, CLKOUT1)
    begin
        if LOCKED = '1' then
            CLKOUT1_AND <= CLKOUT1;
            CLKOUT2_AND <= CLKOUT2;
        else
            CLKOUT1_AND <= '0';
            CLKOUT2_AND <= '0';
        end if;
    end process;
    
    end_simulation: process
    begin
        wait for 5000 ns;
        report "Simulation finished" severity note;
        wait;
    end process;


end Behavioral;
