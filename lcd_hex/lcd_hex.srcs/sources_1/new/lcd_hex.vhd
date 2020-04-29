----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2020 20:16:22
-- Design Name: 
-- Module Name: lcd_hex - rtl
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


entity lcd_hex is
    port(
        sys_clk_i : in std_ulogic;
        rst_i : in std_ulogic;
        digit_o : out std_ulogic_vector (7 downto 0);
        sel_o : out std_ulogic_vector (5 downto 0)
    );
end lcd_hex;

architecture rtl of lcd_hex is

    constant sec_c : natural := 25000000;
    signal sec_s : natural range 0 to sec_c;

    signal cnt_s : unsigned (23 downto 0);

    signal num_s : unsigned (3 downto 0);

    signal lcd_cnt_s : natural;

    function f_hex (
        hex : in unsigned (3 downto 0))
        return std_ulogic_vector is
        variable digit_v : std_ulogic_vector(7 downto 0);
        
    begin
        if (hex = b"0000") then
            digit_v := b"11000000";
        elsif (hex = b"0001") then
            digit_v := b"11111001"; 
        elsif (hex = b"0010") then
            digit_v := b"10100100"; 
        elsif (hex = b"0011") then
            digit_v := b"10110000"; 
        elsif (hex = b"0100") then
            digit_v := b"10011001"; 
        elsif (hex = b"0101") then
            digit_v := b"10010010"; 
        elsif (hex = b"0110") then
            digit_v := b"10000010"; 
        elsif (hex = b"0111") then
            digit_v := b"11111000"; 
        elsif (hex = b"1000") then
            digit_v := b"10000000";
        elsif (hex = b"1001") then
            digit_v := b"10010000";
        elsif (hex = b"1010") then
            digit_v := b"10001000";
        elsif (hex = b"1011") then
            digit_v := b"10000011";
        elsif (hex = b"1100") then
            digit_v := b"11000110";
        elsif (hex = b"1101") then
            digit_v := b"10100001";
        elsif (hex = b"1110") then
            digit_v := b"10000110";
        else
            digit_v := b"10001110";
        end if;
    return std_ulogic_vector(digit_v);
    end;

begin
    p_main : process (sys_clk_i, rst_i) is
    begin
        if rst_i = '0' then
            cnt_s <= (others => '0');
            sec_s <= 0;
            lcd_cnt_s <= 0;
            num_s <= (others => '0');
            sel_o <= b"111110";
            digit_o <= f_hex(num_s);
        elsif rising_edge(sys_clk_i) then
            if sec_s = sec_c - 1 then
                sec_s <= 0;
                cnt_s <= cnt_s + 1;
                if cnt_s = (2 ** 24 -1) then
                    cnt_s <= (others => '0');
                end if;
            else
                sec_s <= sec_s + 1;
            end if;

            lcd_cnt_s <= lcd_cnt_s + 1;
            if lcd_cnt_s < 10 then
                sel_o <= b"111111";
                digit_o <= f_hex(num_s);  
            elsif lcd_cnt_s < 500 then
                num_s <= cnt_s (3 downto 0);
                sel_o <= b"111110";
                digit_o <= f_hex(num_s);
            elsif lcd_cnt_s < 510 then
                sel_o <= b"111111";
                digit_o <= f_hex(num_s);
            elsif lcd_cnt_s < 1000 then
                num_s <= cnt_s (7 downto 4);
                sel_o <= b"111101";
                digit_o <= f_hex(num_s);      
            elsif lcd_cnt_s < 1010 then
                sel_o <= b"111111";
                digit_o <= f_hex(num_s);
            elsif lcd_cnt_s < 1500 then
                num_s <= cnt_s (11 downto 8);
                sel_o <= b"111011";
                digit_o <= f_hex(num_s);        
            elsif lcd_cnt_s < 1510 then
                sel_o <= b"111111";
                digit_o <= f_hex(num_s);
            elsif lcd_cnt_s < 2000 then
                num_s <= cnt_s (15 downto 12);
                sel_o <= b"110111";
                digit_o <= f_hex(num_s);     
            elsif lcd_cnt_s < 2010 then
                sel_o <= b"111111";
                digit_o <= f_hex(num_s);
            elsif lcd_cnt_s < 2500 then
                num_s <= cnt_s (19 downto 16);
                sel_o <= b"101111";
                digit_o <= f_hex(num_s);      
            elsif lcd_cnt_s < 2510 then
                sel_o <= b"111111";
                digit_o <= f_hex(num_s);
            elsif lcd_cnt_s < 3000 then
                num_s <= cnt_s (23 downto 20);
                sel_o <= b"011111";
                digit_o <= f_hex(num_s);      
            elsif lcd_cnt_s < 3010 then
                lcd_cnt_s <= 0;
                sel_o <= b"111111";
                digit_o <= f_hex(num_s);
            end if;
        end if;
    end process p_main;
end rtl;
