----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2020 16:59:18
-- Design Name: 
-- Module Name: led_blink - Behavioral
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


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY led_blink IS
--  Port ( );
    PORT (
        i_clock     : IN STD_ULOGIC;
        rst         : IN STD_ULOGIC;
        o_led_drive : OUT STD_ULOGIC_VECTOR(3 DOWNTO 0)
        ); 
END led_blink;

ARCHITECTURE rtl OF led_blink IS

    CONSTANT c_cnt_100Hz    : NATURAL := 250000;
    CONSTANT c_cnt_50Hz     : NATURAL := 500000;
    CONSTANT c_cnt_10Hz     : NATURAL := 2500000;
    CONSTANT c_cnt_1Hz      : NATURAL := 25000000;
    
    SIGNAL r_cnt_100Hz      : NATURAL RANGE 0 TO c_cnt_100Hz;
    SIGNAL r_cnt_50Hz       : NATURAL RANGE 0 TO c_cnt_50Hz;
    SIGNAL r_cnt_10Hz       : NATURAL RANGE 0 TO c_cnt_10Hz;
    SIGNAL r_cnt_1Hz        : NATURAL RANGE 0 TO c_cnt_1Hz;
    
    SIGNAL r_toggle_100Hz   : STD_ULOGIC := '0';
    SIGNAL r_toggle_50Hz    : STD_ULOGIC := '0';
    SIGNAL r_toggle_10Hz    : STD_ULOGIC := '0';
    SIGNAL r_toggle_1Hz     : STD_ULOGIC := '0';
    
BEGIN
    p_100Hz : PROCESS (i_clock, rst) IS
    BEGIN
        IF rst = '0' THEN
            r_cnt_100Hz <= 0;
            r_toggle_100Hz <= '0';
        ELSIF RISING_EDGE(i_clock) THEN
            IF r_cnt_100Hz = c_cnt_100Hz - 1 THEN
                r_toggle_100Hz <= NOT r_toggle_100Hz;
                r_cnt_100Hz <= 0;
            ELSE
                r_cnt_100Hz <= r_cnt_100Hz +1;
            END IF;
        END IF;
    END PROCESS p_100Hz;
    
    p_50Hz : PROCESS (i_clock, rst) IS
    BEGIN
        IF rst = '0' THEN
            r_cnt_50Hz <= 0;
            r_toggle_50Hz <= '0';
        ELSIF RISING_EDGE(i_clock) THEN
            IF r_cnt_50Hz = c_cnt_50Hz - 1 THEN
                r_toggle_50Hz <= NOT r_toggle_50Hz;
                r_cnt_50Hz <= 0;
            ELSE
                r_cnt_50Hz <= r_cnt_50Hz +1;
            END IF;
        END IF;
    END PROCESS p_50Hz;
    
    p_10Hz : PROCESS (i_clock) IS
    BEGIN
        IF rst = '0' THEN
            r_cnt_10Hz <= 0;
            r_toggle_10Hz <= '0';
        ELSIF RISING_EDGE(i_clock) THEN
            IF r_cnt_10Hz = c_cnt_10Hz - 1 THEN
                r_toggle_10Hz <= NOT r_toggle_10Hz;
                r_cnt_10Hz <= 0;
            ELSE
                r_cnt_10Hz <= r_cnt_10Hz +1;
            END IF;
        END IF;
    END PROCESS p_10Hz;
    
    p_1Hz : PROCESS (i_clock) IS
    BEGIN
        IF rst = '0' THEN
            r_cnt_1Hz <= 0;
            r_toggle_1Hz <= '0';
        ELSIF RISING_EDGE(i_clock) THEN
            IF r_cnt_1Hz = c_cnt_1Hz - 1 THEN
                r_toggle_1Hz <= NOT r_toggle_1Hz;
                r_cnt_1Hz <= 0;
            ELSE
                r_cnt_1Hz <= r_cnt_1Hz +1;
            END IF;
        END IF;
    END PROCESS p_1Hz;
                    
    o_led_drive <= r_toggle_100Hz & r_toggle_50Hz & r_toggle_10Hz & r_toggle_1Hz;
END rtl;
        
    
