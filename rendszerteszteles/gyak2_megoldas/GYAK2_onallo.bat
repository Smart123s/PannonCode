cd ..

REM kapcsolot allitsuk olyan helyzetbe, hogy led vilagitson
batchControl -init
batchControl -comment comment week_2_practice_1
batchControl -getHilState

batchControl -hwfi switch 1
batchControl -comment Plausibility check: switch is on
batchControl -assert switch 1

batchControl -hwfi pot 192
batchControl -assert pot_led 1111

batchControl -hwfi pot 200
batchControl -assert pot_led 1111

batchControl -hwfi pot 255
batchControl -assert pot_led 1111

batchControl -start
