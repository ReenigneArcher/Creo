@echo off
::set variables
set filename=dxf2sw

::file cleanup
if exist "C:\PTC\data\Temp\%filename%_dxf__out.log.1" del /s "C:\PTC\data\Temp\%filename%_dxf__out.log.1"
if exist "C:\PTC\data\Temp\%filename%.err" del /s "C:\PTC\data\Temp\%filename%.err"

::error checking
if not exist "C:\PTC\data\Temp\%filename%.dxf" echo DXF export failed, exiting. && timeout /t 20 && goto end
if not exist "C:\Program Files\SOLIDWORKS Corp\SOLIDWORKS\swShellFileLauncher.exe" echo SOLIDWORKS not installed correctly, exiting. && timeout /t 20 && goto end

::open dxf file in new or existing SOLIDWORKS session
sleep 1
start "" "C:\Program Files\SOLIDWORKS Corp\SOLIDWORKS\swShellFileLauncher.exe" "C:\PTC\data\Temp\%filename%.dxf"
:end