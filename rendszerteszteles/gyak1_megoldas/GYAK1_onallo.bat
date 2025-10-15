REM hőmérséklet 30-ra állítása -- led világít
batchControl -init
batchControl -comment temp_30_led_on
batchControl -getHilState
batchControl -hwfi temp 30
batchControl -assert temp_led 1


REM hőmérséklet 40-ra állítása -- led világít
batchControl -comment temp_40_led_on
batchControl -hwfi temp 40
batchControl -assert temp_led 1


REM hőmérséklet 29-ra állítása -- led nem világít
batchControl -comment temp_29_led_off
batchControl -hwfi temp 29
batchControl -assert temp_led 0
batchControl -start
pause
