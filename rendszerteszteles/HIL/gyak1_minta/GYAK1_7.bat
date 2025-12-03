batchControl -init
batchControl -comment week_1 practice_7
batchControl -hwfi temp 40
batchControl -comment plausibility check: temp is 40
batchControl -assert temp 40
batchControl -start
pause