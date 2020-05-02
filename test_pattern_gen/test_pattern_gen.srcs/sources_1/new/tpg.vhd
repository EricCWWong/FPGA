----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2020 12:35:59
-- Design Name: 
-- Module Name: tpg - Behavioral
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


entity tpg is
    port(
        sys_clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        tready_i : in std_ulogic;
        tdata_o : out std_ulogic_vector (23 downto 0);
        tuser_o : out std_ulogic;
        tlast_o : out std_ulogic;
        tvalid_o : out std_ulogic
    );
end tpg;

architecture rtl of tpg is

    constant width_c : natural := 1920;
    constant height_c : natural := 1080;
    constant square_c : natural := 180;


    signal width_s : natural range 0 to width_c;
    signal height_s : natural range 0 to height_c;

begin
    p_main : process (sys_clk_i, rst_i) is
    begin
        if rst_i = '0' then
            tdata_o <= (others => '0');
            tuser_o <= '0';
            tlast_o <= '0';
            tvalid_o <= '0';

        elsif rising_edge(sys_clk_i) then

                
            if (width_s / square_c) mod 2 = 0 then
                if (height_s / height_c) mod 2 = 0 then
                    tdata_o <= (others => '0');
                else
                    tdata_o <= (others => '1');
                end if;
            else
                if (height_s / height_c) mod 2 = 0 then
                    tdata_o <= (others => '1');
                else
                    tdata_o <= (others => '0');
                end if;
            end if;
            
            if width_s = 0 then
                if height_s = 0 then
                    tuser_o <= '1';
                end if;
            elsif width_s = width_c - 1 then
                tlast_o <= '1';
            else
                tuser_o <= '0';
                tlast_o <= '0';
            end if;
            tvalid_o <= '1';
            

            if tready_i = '1' then
                width_s <= width_s + 1;
                
                if width_s = width_c - 1 then
                    width_s <= 0;
                    height_s <= height_s + 1;

                    if height_s = height_c - 1 then
                        height_s <= 0;
                    end if;
                end if;
            end if;
        end if; 
    end process p_main;    
end rtl;
