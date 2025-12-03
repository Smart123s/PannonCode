batchControl -init
batchControl -comment week_1 practice_6
batchControl -getHilState
batchControl -hwfi temp 40
batchControl -getHilState
batchControl -comment plausibility check
batchControl -assert temp 40
batchControl -start
pause