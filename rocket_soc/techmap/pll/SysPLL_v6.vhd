-- file: SysPLL_v6.vhd
-- 
-- (c) Copyright 2008 - 2011 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
------------------------------------------------------------------------------
-- User entered comments
------------------------------------------------------------------------------
-- None
--
------------------------------------------------------------------------------
-- "Output    Output      Phase     Duty      Pk-to-Pk        Phase"
-- "Clock    Freq (MHz) (degrees) Cycle (%) Jitter (ps)  Error (ps)"
------------------------------------------------------------------------------
-- CLK_OUT1____40.000______0.000______50.0______135.255_____89.971
--
------------------------------------------------------------------------------
-- "Input Clock   Freq (MHz)    Input Jitter (UI)"
------------------------------------------------------------------------------
-- __primary_________200.000____________0.010

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity SysPLL_v6 is
port
 (-- Clock in ports
  CLK_IN            : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic;
  -- Status and control signals
  RESET             : in     std_logic;
  LOCKED            : out    std_logic
 );
end SysPLL_v6;

architecture xilinx of SysPLL_v6 is
  attribute CORE_GENERATION_INFO : string;
  --attribute CORE_GENERATION_INFO of xilinx : architecture is "SysPLL_v6,clk_wiz_v3_6,{component_name=SysPLL_v6,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,feedback_source=FDBK_AUTO,primtype_sel=DCM_ADV,num_out_clk=1,clkin1_period=5.000,clkin2_period=10.0,use_power_down=false,use_reset=true,use_locked=true,use_inclk_stopped=false,use_status=false,use_freeze=false,use_clk_valid=false,feedback_type=SINGLE,clock_mgr_type=MANUAL,manual_override=false}";
  -- Output clock buffering / unused connectors
  signal clkfbout         : std_logic;
  signal clkfbout_buf     : std_logic;
  signal clkout           : std_logic;
  signal clkout1_unused   : std_logic;
  signal clkout2_unused   : std_logic;
  signal clkout3_unused   : std_logic;
  signal clkout4_unused   : std_logic;
  signal clkout5_unused   : std_logic;
  signal clkout6_unused   : std_logic;
  signal clkout7_unused   : std_logic;
    -- Dynamic programming unused signals
  signal do_unused        : std_logic_vector(15 downto 0);
  signal drdy_unused      : std_logic;
  -- Dynamic phase shift unused signals
  signal psdone_unused    : std_logic;
begin


  -- Clocking primitive
  --------------------------------------
  -- Instantiation of the MMCM primitive
  --    * Unused inputs are tied off
  --    * Unused outputs are labeled unused
    dcm_adv_inst : DCM_ADV
    generic map (
        CLKDV_DIVIDE => 13.0,
        CLKFX_DIVIDE => 1,
        CLKFX_MULTIPLY => 2,
        CLKIN_DIVIDE_BY_2 => FALSE,
        CLKIN_PERIOD => 10.0,
        CLKOUT_PHASE_SHIFT => "NONE",
        CLK_FEEDBACK => "1X",
        DCM_PERFORMANCE_MODE => "MAX_SPEED",
        DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS",
        DFS_FREQUENCY_MODE => "LOW",
        DLL_FREQUENCY_MODE => "LOW",
        DUTY_CYCLE_CORRECTION => TRUE,
        FACTORY_JF => X"F0F0",
        PHASE_SHIFT => 0,
        SIM_DEVICE => "VIRTEX5",
        STARTUP_WAIT => FALSE)
    port map (
        CLK0        => clkfbout,
        CLK180      => clkout1_unused,
        CLK270      => clkout2_unused,
        CLK2X       => clkout3_unused,
        CLK2X180    => clkout4_unused,
        CLK90       => clkout5_unused,
        CLKDV       => clkout,
        CLKFX       => clkout6_unused,
        CLKFX180    => clkout7_unused,

        -- Feedback and clock in
        CLKFB       => clkfbout_buf,
        CLKIN       => CLK_IN,

        -- Dynamic reconfiguration (unused)
        DADDR       => (others => '0'),
        DCLK        => '0',
        DEN         => '0',
        DI          => (others => '0'),
        DO          => do_unused,
        DRDY        => drdy_unused,
        DWE         => '0',

        -- Dynamic phase shift (unused)
        PSCLK       => '0',
        PSEN        => '0',
        PSINCDEC    => '0',
        PSDONE      => psdone_unused,

        -- Control and status
        LOCKED      => LOCKED,
        RST         => RESET
    );


  -- Output buffering
  -------------------------------------
  clkf_buf : BUFG
  port map
   (O => clkfbout_buf,
    I => clkfbout);


  clkout1_buf : BUFG
  port map
   (O   => CLK_OUT1,
    I   => clkout);



end xilinx;
