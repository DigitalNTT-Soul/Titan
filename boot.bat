taskkill /IM luvit.ex* /F
cls
start /min cmd.exe @cmd /c "luvit core.lua"
start /min cmd.exe @cmd /c "luvit silence.lua"
exit