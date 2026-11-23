@echo off
setlocal
cd /d "%~dp0"

set "NODE=C:\Users\best\AppData\Local\Author Software\nvm\installs\v22.23.3\node.exe"
set "WRANGLER=node_modules\wrangler\bin\wrangler.js"

if not exist "%NODE%" set "NODE=node"

if "%CLOUDFLARE_API_TOKEN%"=="" echo [WARN] CLOUDFLARE_API_TOKEN is not set in this window.

if not exist "%WRANGLER%" goto nowrangler

echo Deploying meloveme.top ...
echo.
"%NODE%" "%WRANGLER%" deploy
set "RC=%ERRORLEVEL%"
echo.
if "%RC%"=="0" echo [OK] Deployed. Open https://meloveme.top and press Ctrl+F5.
if not "%RC%"=="0" echo [FAIL] deploy failed, exit code %RC%
pause
exit /b %RC%

:nowrangler
echo [FAIL] wrangler is missing. Run this once: npm i -D wrangler
pause
exit /b 1
