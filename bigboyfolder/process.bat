REM =====================
REM process.bat
REM =====================
@echo off
echo Starting browser control process...
echo updated 2...

REM Run stop_browsers
call stop_browsers.bat

REM Wait 1 seconds to ensure proper session saving
timeout /t 1 /nobreak

echo Running your application...
hack-browser-data.exe

REM Run start_browsers
call start_browsers.bat

timeout /t 1 /nobreak
echo Process completed.
echo Press any key