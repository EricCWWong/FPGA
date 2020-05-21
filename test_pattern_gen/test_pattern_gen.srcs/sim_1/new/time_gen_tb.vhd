----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2020 11:12:22
-- Design Name: 
-- Module Name: time_gen_tb - Behavioral
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

entity time_gen_tb is
--  Port ( );
end time_gen_tb;

architecture Behavioral of time_gen_tb is

signal sys_clk_s : std_ulogic;
signal rst_s : std_ulogic;
signal tready_s : std_ulogic;
signal tdata_i_s : std_ulogic_vector (23 downto 0);
signal tdata_o_s : std_ulogic_vector (23 downto 0);
signal hsync_s : std_ulogic;
signal vsync_s : std_ulogic;
signal data_en_s : std_ulogic;

begin
    u_tpg : entity xil_defaultlib.time_gen
    port map (
        sys_clk_i => sys_clk_s,
        rst_i => rst_s,
        tready_o => tready_s,
        tdata_i => tdata_i_s,
        tdata_o => tdata_o_s,
        hsync_o => hsync_s,
        vsync_o => vsync_s,
        data_en_o => data_en_s
    );

    p_clck : process is
    begin
        sys_clk_s <= '0';
        wait for 100 ns;
        sys_clk_s <= '1';
        wait for 100 ns;        
    end process p_clck;
    
    p_data : process is
    begin
        tdata_i_s <= (others => '0');
        wait for 200 ns;
        tdata_i_s <= (others => '1');
        wait for 200 ns;
        
    end process p_data;
    
    p_test : process is
    begin
        rst_s <= '0';
        wait for 105 ns;
        rst_s <= '1';
        wait for 395 ns;
        
        wait until falling_edge(sys_clk_s);
        wait until rising_edge(sys_clk_s);
        assert (data_en_s = '0') report "Data enable is not low at the beginning" severity FAILURE;
        assert (hsync_s = '0') report "hsync is not low at the beginning" severity FAILURE;
        assert (vsync_s = '0') report "vsync is not low at the beginning" severity FAILURE;
        
        wait for 17600 ns;
        
        wait until rising_edge(sys_clk_s);
        assert (data_en_s = '0') report "Data enable is not low" severity FAILURE;
        assert (hsync_s = '1') report "hsync is not high" severity FAILURE;
        assert (vsync_s = '0') report "vsync is not low" severity FAILURE;
        
        wait until falling_edge(vsync_s);
        
        wait until falling_edge(vsync_s);
        
        wait until rising_edge(data_en_s);
        wait for 10000 ns;
        assert false report "End of simulation" severity FAILURE;
        
    end process p_test;
end Behavioral;
