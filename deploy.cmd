@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo ========================================
echo   Deploy meloveme.top
echo ========================================
echo.
"C:\Users\best\AppData\Local\Author Software\nvm\installs\v22.23.3\node.exe" "node_modules\wrangler\bin\wrangler.js" deploy
echo.
echo 如果上面出现 Success，打开 https://meloveme.top 按 Ctrl+F5 查看
pause
