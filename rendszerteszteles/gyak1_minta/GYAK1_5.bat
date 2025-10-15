batchControl -init
batchControl -comment week_1 practice_5
batchControl -getHilState
batchControl -comment assert on input signal
batchControl -assert temp 21:4
batchControl -comment assert on output signal
batchControl -assert temp_led 0
batchControl -start
pause