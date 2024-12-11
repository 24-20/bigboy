REM =====================
REM start_browsers.bat
REM =====================
@echo off
setlocal EnableDelayedExpansion
echo Starting browsers with session restoration...



REM Start Chrome with enhanced session restore
echo Starting Chrome...
start "" /B "C:\Program Files\Google\Chrome\Application\chrome.exe" ^
    --restore-last-session ^
    --session-restore-standalone-timeout=60 ^
    --disable-session-crashed-bubble ^
    --disable-features=TabGroups ^
    --password-store=basic ^
    --no-first-run


REM Start Edge with enhanced session restore
echo Starting Edge...
start "" /B "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" ^
    --restore-last-session ^
    --session-restore-standalone-timeout=60 ^
    --disable-session-crashed-bubble ^
    --disable-features=TabGroups ^
    --password-store=basic ^
    --no-first-run

echo Browser restart process completed.
