REM =====================
REM stop_browsers.bat
REM =====================
@echo off
setlocal EnableDelayedExpansion
echo Gracefully closing browsers to preserve sessions...

REM Save current timestamp to a file for session tracking
echo %date% %time% > "%TEMP%\browser_session_time.txt"

REM Close Chrome gracefully first with session saving
echo Closing Chrome...
for /f "tokens=2 delims==" %%a in ('wmic process where "name='chrome.exe'" get commandline /value ^| find "user-data-dir"') do (
    set "chrome_profile=%%a"
)
taskkill /IM chrome.exe >nul 2>&1

REM Close Edge gracefully with session saving
echo Closing Edge...
for /f "tokens=2 delims==" %%a in ('wmic process where "name='msedge.exe'" get commandline /value ^| find "user-data-dir"') do (
    set "edge_profile=%%a"
)
taskkill /IM msedge.exe >nul 2>&1

timeout /t 1 /nobreak >nul

REM Double-check and force close any remaining instances
taskkill /F /IM chrome.exe /T 2>nul
taskkill /F /IM msedge.exe /T 2>nul

echo All browser processes have been stopped.
