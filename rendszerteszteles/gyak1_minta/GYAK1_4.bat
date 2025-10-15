batchControl -init
batchControl -comment week_1 practice_4
batchControl -getHilState
batchControl -assert temp_led 0
batchControl -assert temp_led 1
batchControl -start
pause