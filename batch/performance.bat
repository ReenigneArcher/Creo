REM this script accepts one argument passed to determine the number of CPUs to use in Creo
REM a lower number will use more CPU cores
REM a higher number will use less CPU cores
@echo off
cd %homedrive%\Users\%username%
IF EXIST config.pro (
	IF EXIST config.pro.bak del /s config.pro.bak
	REN config.pro config.pro.bak
)
type config.pro.bak | findstr /b /v "CPUS_TO_USE" > config.pro

SET FACTOR=%1
SET /A N = %NUMBER_OF_PROCESSORS%/%FACTOR%
IF %N%==0 SET N=1
(echo CPUS_TO_USE %N%)>> config.pro

exit /b 0