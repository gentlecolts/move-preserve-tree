@echo off
move "%~1\*" "%~2"

FOR /f "tokens=*" %%i IN ('dir /a:d /b "%~1\*"') DO (
mkdir "%~2\%%i"
move.bat "%~1\%%i" "%~2\%%i" )

exit /b