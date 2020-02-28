@echo off
setlocal enableDelayedExpansion
::set initial variables
set search=appendCellsToTableRow
set input=Model_Info.html
set output=content.txt
set application=%1

::change to the temp directory
cd c:\ptc\data\temp

::search the input file and output
findstr /i !search! !input!>!output!

::output the search to a temp file
set /p content=<!output!

::search the temp file and keep only the information from between the two '
for /f "tokens=2 delims='" %%a in ("!content!") do (
  set cad_file_path=%%a
)

::replace the four \ with one
set cad_file_path=%cad_file_path:\\\\=\%

::verify the file has been saved
if !cad_file_path!==--- (
    echo.File path not found. Ensure the file has been saved. Exiting mapkey.
    goto error
)

if !application!=="sw" (
    if not exist "C:\Program Files\SOLIDWORKS Corp\SOLIDWORKS\SLDWORKS.exe" echo.SOLIDWORKS program not found. Exiting mapkey. && goto error
    start "" "C:\Program Files\SOLIDWORKS Corp\SOLIDWORKS\SLDWORKS.exe" "!cad_file_path!"
    echo.Loading file in SOLIDWORKS. Exiting mapkey.
    goto end
)

if !application!=="ed" (
    if not exist "C:\Program Files\SOLIDWORKS Corp\eDrawings\eDrawings.exe" echo.eDrawings program not found. Exiting mapkey. && goto error
    start "" "C:\Program Files\SOLIDWORKS Corp\eDrawings\eDrawings.exe" "!cad_file_path!"
    echo.Loading file in eDrawings. Exiting mapkey.
    goto end
)

echo Mapkey error. Exiting mapkey.
goto error

::delete the input and output files
:end
del /s !input! > NUL
del /s !output! > NUL
del /s !app! > NUL
endlocal
exit /b 0

:error
del /s !input! > NUL
del /s !output! > NUL
del /s !app! > NUL
endlocal
timeout /t 15
exit /b 1