cd ..
batchControl -init
batchControl -comment Inject random error
batchControl -comment week 3 practice 4
batchControl -bug_on

REM R_0: pot 0..63 -> 1 Led vilagit (1000)
batchControl -comment "R_0: pot 0..63"
batchControl -comment "Also teszt: 0"
batchControl -swfi pot 0
batchControl -assert pot_led 1000
batchControl -comment "Kozotte teszt: 60"
batchControl -swfi pot 60
batchControl -assert pot_led 1000
batchControl -comment "Felso teszt: 63"
batchControl -swfi pot 63
batchControl -assert pot_led 1000

REM R_1: pot 64..127 -> 1-2 Led vilagit (1100)
batchControl -comment "R_1: pot 64..127"
batchControl -comment "Also teszt: 64"
batchControl -swfi pot 64
batchControl -assert pot_led 1100
batchControl -comment "Kozotte teszt: 100"
batchControl -swfi pot 100
batchControl -assert pot_led 1100
batchControl -comment "Felso teszt: 127"
batchControl -swfi pot 127
batchControl -assert pot_led 1100

REM R_2: pot 128..191 -> 1-2-3 Led vilagit (1110)
batchControl -comment "R_2: pot 128..191"
batchControl -comment "Also teszt: 128"
batchControl -swfi pot 128
batchControl -assert pot_led 1110
batchControl -comment "Kozotte teszt: 160"
batchControl -swfi pot 160
batchControl -assert pot_led 1110
batchControl -comment "Testing upper boundary: 191"
batchControl -swfi pot 191
batchControl -assert pot_led 1110

REM R_3: pot 192..255 -> 4 Led vilagit (1111)
batchControl -comment "R_3: pot 192..255"
batchControl -comment "Also teszt: 192"
batchControl -swfi pot 192
batchControl -assert pot_led 1111
batchControl -comment "Kozotte teszt: 220"
batchControl -swfi pot 220
batchControl -assert pot_led 1111
batchControl -comment "Testing upper boundary: 255"
batchControl -swfi pot 255
batchControl -assert pot_led 1111

REM R_4: Kapcsolo be -> LED vilagit
batchControl -comment "R_4: Switch ON"
batchControl -swfi switch 1
batchControl -assert switch_led 1

REM R_5: Kapcsolo ki -> LED nem vilagit
batchControl -comment "R_5: Switch OFF"
batchControl -swfi switch 0
batchControl -assert switch_led 0

REM R_6ez: Homerseklet > 30 -> temp LED vilagit
batchControl -comment "R_6_1: Temp > 30"
batchControl -comment "Also teszt: 31"
batchControl -swfi temp 31
batchControl -assert temp_led 1
batchControl -comment "Felette ertek: 50"
batchControl -swfi temp 50
batchControl -assert temp_led 1

REM R_7ez: Homerseklet <= 30 -> temp LED nem vilagit
batchControl -comment "R_7_1: Temp <= 30"
batchControl -comment "Pontos ertek: 30"
batchControl -swfi temp 30
batchControl -assert temp_led 0
batchControl -comment "Alatta ertek: 15"
batchControl -swfi temp 15
batchControl -assert temp_led 0

batchControl -start
pause