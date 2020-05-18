----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2020 22:47:39
-- Design Name: 
-- Module Name: tpg_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library xil_defaultlib;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tpg_tb is
--  Port ( );
end tpg_tb;

architecture Behavioral of tpg_tb is

signal sys_clk_s : std_ulogic;
signal rst_s : std_ulogic;
signal tready_s : std_ulogic;
signal tdata_s : std_ulogic_vector (23 downto 0);
signal tuser_s : std_ulogic;
signal tlast_s : std_ulogic;
signal tvalid_s : std_ulogic;

begin
    u_tpg : entity xil_defaultlib.tpg
    port map (
        sys_clk_i => sys_clk_s,
        rst_i => rst_s,
        tready_i => tready_s,
        tdata_o => tdata_s,
        tuser_o => tuser_s,
        tlast_o => tlast_s,
        tvalid_o => tvalid_s
    );

    p_clck : process is
    begin
        sys_clk_s <= '0';
        wait for 100 ns;
        sys_clk_s <= '1';
        wait for 100 ns;        
    end process p_clck;
    
    p_test : process is
    begin
        rst_s <= '0';
        wait for 105 ns;
        rst_s <= '1';
        tready_s <= '1';
        wait for 395 ns;
        
        wait until falling_edge(sys_clk_s);
        wait until rising_edge(sys_clk_s);
        assert (tdata_s = x"000000") report "Wrong colour for this pixel" severity FAILURE;
        assert (tuser_s = '0') report "TUser should be low" severity FAILURE;
        assert (tlast_s = '0') report "TLast should be low" severity FAILURE;
        
        wait for 8000 ns;
        
        wait until rising_edge(sys_clk_s);
        assert (tdata_s = x"ffffff") report "Wrong colour for this pixel" severity FAILURE;
        assert (tuser_s = '0') report "TUser should be low" severity FAILURE;
        assert (tlast_s = '0') report "TLast should be low" severity FAILURE;
        
        wait until rising_edge(tlast_s);
        
        wait until rising_edge(tuser_s);
        wait for 10000 ns;
        tready_s <= '0';
        wait for 8000 ns;
        tready_s <= '1';
        wait for 10000 ns;
        
        assert false report "End of simulation" severity FAILURE;
        
    end process p_test;
end Behavioral;
