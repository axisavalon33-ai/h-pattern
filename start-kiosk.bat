@echo off
REM MEDSCOPE II - for a TOUCH SCREEN connected to this laptop.
REM Starts the screen server, then opens Chrome locked in full screen
REM (visitors cannot see the address bar or close the page).
REM To exit Chrome kiosk mode: press Alt+F4 on the laptop keyboard.
cd /d "%~dp0"
start "MEDSCOPE server" cmd /c start-tv.bat
echo Starting... please wait.
timeout /t 4 /nobreak >nul
start "" chrome --kiosk --no-first-run --disable-pinch --overscroll-history-navigation=0 --autoplay-policy=no-user-gesture-required --disable-features=TranslateUI --user-data-dir="%TEMP%\medscope-chrome" http://localhost:8000
if errorlevel 1 (
  echo.
  echo  Google Chrome was not found. Install Chrome from https://www.google.com/chrome/
  echo  or open http://localhost:8000 in any browser and press F11.
  pause
)
