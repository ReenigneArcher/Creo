REM this script accepts the following arguments
REM "clear" which will clear the current option from the user config.pro and not reset it
@echo off

set arg=%1

:clear
cd %homedrive%\Users\%username%
IF EXIST config.pro (
	IF EXIST config.pro.bak del /s config.pro.bak
	REN config.pro config.pro.bak
)
type config.pro.bak | findstr /b /v "SYSTEM_COLORS_FILE" > config.pro
if arg=="clear" goto :eof

:set
echo SYSTEM_COLORS_FILE %homedrive%\Users\%username%\Documents\syscol.scl>> config.pro

:eof
exit /b 0