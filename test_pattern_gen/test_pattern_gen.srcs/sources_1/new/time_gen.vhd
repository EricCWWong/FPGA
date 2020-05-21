----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2020 12:31:42
-- Design Name: 
-- Module Name: time_gen - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


entity time_gen is
    port(
        sys_clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        tdata_i : in std_ulogic_vector (23 downto 0);
        tready_o : out std_ulogic;
        tdata_o : out std_ulogic_vector (23 downto 0);
        hsync_o : out std_ulogic;
        vsync_o : out std_ulogic;
        data_en_o : out std_ulogic
    );
end time_gen;

architecture rtl of time_gen is

    constant hsync_cyc_c : natural := 2200;
    constant vsync_cyc_c : natural := 1125;


    signal hsync_cyc_s : natural range 0 to hsync_cyc_c;
    signal vsync_cyc_s : natural range 0 to vsync_cyc_c;
    
    signal tdata_s : std_ulogic_vector (23 downto 0);

begin
    p_main : process (sys_clk_i, rst_i) is
    begin
        if rst_i = '0' then
            tready_o <= '0';
            data_en_o <= '0';
            hsync_o <= '0';
            vsync_o <= '0';
            hsync_cyc_s <= 0;
            vsync_cyc_s <= 0;

        elsif rising_edge(sys_clk_i) then
            hsync_cyc_s <= hsync_cyc_s + 1;
            hsync_o <= '0';
            vsync_o <= '0';
            data_en_o <= '1';
            tready_o <= '1';
            
            tdata_s <= tdata_i;
            tdata_o <= tdata_s;
            
            
            if hsync_cyc_s < 280 then
                if hsync_cyc_s < 279 then
                    tready_o <= '0';
                end if;
                data_en_o <= '0';
                if hsync_cyc_s > 87 and hsync_cyc_s < 132 then
                    hsync_o <= '1';
                end if;
            elsif hsync_cyc_s = hsync_cyc_c - 1 then
                hsync_cyc_s <= 0;
                tready_o <= '0';
                vsync_cyc_s <= vsync_cyc_s + 1;
            end if;
            
            if vsync_cyc_s < 45 then
                data_en_o <= '0';
                tready_o <= '0';
                if vsync_cyc_s > 3 and vsync_cyc_s < 9 then
                    vsync_o <= '1';
                end if;
            elsif vsync_cyc_s = vsync_cyc_c then
                vsync_cyc_s <= 0;
            end if;
        end if; 
    end process p_main;    
end rtl;
