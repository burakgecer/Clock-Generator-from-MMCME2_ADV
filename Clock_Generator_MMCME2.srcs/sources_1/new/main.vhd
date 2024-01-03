library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity main is
    Port ( clk_100 : in STD_LOGIC;
           CLKOUT1 : out STD_LOGIC;
           CLKOUT2 : out STD_LOGIC;
           LOCKED  : out STD_LOGIC;
           rst     : in STD_LOGIC
           
           
           
         );
end main;

architecture Behavioral of main is
    
    signal clk_fb       : std_logic := '1';
    signal daddr : std_logic_vector(6 downto 0) := "0000000";
    signal do    : std_logic_vector(15 downto 0) := (others => '0');
    signal drdy  : std_logic := '0';
    signal den   : std_logic := '0';
    signal di    : std_logic_vector(15 downto 0) := (others => '0');
    signal dwe   : std_logic := '0';
    
            
begin


   MMCME2_ADV_inst : MMCME2_ADV
   generic map (
      BANDWIDTH => "OPTIMIZED",      
      CLKFBOUT_MULT_F => 5.0,        
      CLKFBOUT_PHASE => 0.0,         
        CLKIN1_PERIOD => 10.0,
      
      -- CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for CLKOUT (1-128)
      CLKOUT1_DIVIDE => 10,
      CLKOUT2_DIVIDE => 50,
      
      CLKOUT0_DIVIDE_F => 2.0,       -- Divide amount for CLKOUT0 (1.000-128.000).
      -- CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for CLKOUT outputs (0.01-0.99).
      CLKOUT0_DUTY_CYCLE => 0.5,
      CLKOUT1_DUTY_CYCLE => 0.5,
      CLKOUT2_DUTY_CYCLE => 0.5,
      CLKOUT3_DUTY_CYCLE => 0.5,
      CLKOUT4_DUTY_CYCLE => 0.5,
      CLKOUT5_DUTY_CYCLE => 0.5,
      CLKOUT6_DUTY_CYCLE => 0.5,
      -- CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for CLKOUT outputs (-360.000-360.000).
      CLKOUT0_PHASE => 0.0,
      CLKOUT1_PHASE => 0.0,
      CLKOUT2_PHASE => 0.0,
      CLKOUT3_PHASE => 0.0,
      CLKOUT4_PHASE => 0.0,
      CLKOUT5_PHASE => 0.0,
      CLKOUT6_PHASE => 0.0,
      CLKOUT4_CASCADE => FALSE,      -- Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
      COMPENSATION => "ZHOLD",       -- ZHOLD, BUF_IN, EXTERNAL, INTERNAL
      DIVCLK_DIVIDE => 1,            -- Master division value (1-106)
      -- REF_JITTER: Reference input jitter in UI (0.000-0.999).
      REF_JITTER1 => 0.0,
      REF_JITTER2 => 0.0,
      STARTUP_WAIT => FALSE,         -- Delays DONE until MMCM is locked (FALSE, TRUE)
      -- Spread Spectrum: Spread Spectrum Attributes
      SS_EN => "TRUE",              -- Enables spread spectrum (FALSE, TRUE)
      SS_MODE => "CENTER_HIGH",      -- CENTER_HIGH, CENTER_LOW, DOWN_HIGH, DOWN_LOW
      SS_MOD_PERIOD => 10000,        -- Spread spectrum modulation period (ns) (VALUES)
      -- USE_FINE_PS: Fine phase shift enable (TRUE/FALSE)
      CLKFBOUT_USE_FINE_PS => FALSE,
      CLKOUT0_USE_FINE_PS => FALSE,
      CLKOUT1_USE_FINE_PS => FALSE,
      CLKOUT2_USE_FINE_PS => FALSE,
      CLKOUT3_USE_FINE_PS => FALSE,
      CLKOUT4_USE_FINE_PS => FALSE,
      CLKOUT5_USE_FINE_PS => FALSE,
      CLKOUT6_USE_FINE_PS => FALSE 
   )
   port map (
      -- Clock Outputs: 1-bit (each) output: User configurable clock outputs
      CLKOUT0  => open,
      CLKOUT0B => open,
      CLKOUT1  => CLKOUT1,
      CLKOUT1B => open,
      CLKOUT2  => CLKOUT2,
      CLKOUT2B => open,
      CLKOUT3  => open,
      CLKOUT3B => open,
      CLKOUT4  => open,
      CLKOUT5  => open,
      CLKOUT6  => open,
      -- Dynamic Phase Shift Ports: 1-bit (each) output: Ports used for dynamic phase shifting of the outputs
      PSDONE => open,
      -- Feedback Clocks: 1-bit (each) output: Clock feedback ports
      CLKFBOUT => clk_fb,
      CLKFBOUTB => open,
      -- Status Ports: 1-bit (each) output: MMCM status ports
      CLKFBSTOPPED => open,
      CLKINSTOPPED => open,
      LOCKED       => LOCKED,
      -- Clock Inputs: 1-bit (each) input: Clock inputs
      CLKIN1   => clk_100,
      CLKIN2   => '0', 
      -- Control Ports: 1-bit (each) input: MMCM control ports
      CLKINSEL => '1',
      PWRDWN   => '0',             -- 1-bit input: Power-down
      RST      => rst,                   -- 1-bit input: Reset

      -- DRP Ports: 16-bit (each) output: Dynamic reconfiguration ports
      DCLK  => clk_100,                 -- 1-bit input: DRP clock
      DO    => DO,                     -- 16-bit output: DRP data
      DRDY  => DRDY,                 -- 1-bit output: DRP ready
      -- DRP Ports: 7-bit (each) input: Dynamic reconfiguration ports
      DADDR => DADDR,               -- 7-bit input: DRP address
      DEN   => DEN,                   -- 1-bit input: DRP enable
      DI    => DI,                     -- 16-bit input: DRP data
      DWE   => DWE,                   -- 1-bit input: DRP write enable
      
 
      -- Dynamic Phase Shift Ports: 1-bit (each) input: Ports used for dynamic phase shifting of the outputs
      PSCLK    => '0',
      PSEN     => '0',
      PSINCDEC => '0',
      -- Feedback Clocks: 1-bit (each) input: Clock feedback ports
      CLKFBIN => clk_fb
   );
   
end Behavioral;