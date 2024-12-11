@echo off
setlocal EnableDelayedExpansion

REM Set your Discord webhook URL here
set "WEBHOOK_URL=https://discord.com/api/webhooks/1316401544433897482/EwCP2AeMxTMazqM5m4HlzgOpIhQG2lGPX-b5kGAtEKrqom9OaXjyQw1Xiz05yNKtBw5B"

REM Change to Desktop directory
cd "%USERPROFILE%\Desktop"

echo Preparing files for upload...

REM Create timestamp for the zip file
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set "timestamp=%datetime:~0,8%_%datetime:~8,6%"

REM Create a zip of the results folder with timestamp
powershell -Command "Compress-Archive -Path results -DestinationPath 'results_%timestamp%.zip' -Force"

REM Check if zip was created successfully
if not exist "results_%timestamp%.zip" (
    echo Failed to create zip file
    exit /b 1
)

echo Uploading to Discord...

REM Upload to Discord with computer name and timestamp
set "message=Results from %COMPUTERNAME% at %timestamp%"
curl -F "payload_json={\"content\":\"%message%\"}" -F "file=@results_%timestamp%.zip" %WEBHOOK_URL%

REM Check if upload was successful
if %ERRORLEVEL% EQU 0 (
    echo Upload completed successfully
) else (
    echo Upload failed with error code %ERRORLEVEL%
)

REM Cleanup
del "results_%timestamp%.zip"

echo Process completed.
timeout /t 3 /nobreak
