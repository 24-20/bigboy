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

REM Run the exe and wait a bit longer
"%CD%\hack-browser-data.exe"
echo [DEBUG] Waiting for results to be generated...
timeout /t 5 /nobreak

REM Start browsers
call start_browsers.bat

REM Signal completion
del /F /Q "%CD%\running.tmp"
echo Process completed.
