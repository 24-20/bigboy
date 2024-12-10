REM =====================
REM process.bat
REM =====================
@echo off
setlocal EnableDelayedExpansion
cd "%~dp0"

echo Starting browser control process...
echo Running from directory: %CD%

REM Run stop_browsers
call stop_browsers.bat

REM Wait for browsers to close
timeout /t 3 /nobreak
echo Running application...

REM Run the exe
"%CD%\hack-browser-data.exe"

REM Wait for exe to complete
timeout /t 3 /nobreak

REM Start browsers
call start_browsers.bat

REM Signal completion
del /F /Q "%CD%\running.tmp"

echo Process completed.
