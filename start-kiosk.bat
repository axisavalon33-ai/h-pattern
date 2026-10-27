@echo off
REM ==================================================================
REM  MEDSCOPE II - run the screen ON THIS COMPUTER
REM  (the OPS computer inside the touch TV, or a laptop with HDMI +
REM   USB touch cable). No Python, no Wi-Fi, no server needed.
REM  Opens the screen locked in full screen.
REM  To get out: press Alt+F4 on a keyboard.
REM ==================================================================
setlocal
cd /d "%~dp0"
set "PAGE=%~dp0index.html"
set "PROFILE=%LOCALAPPDATA%\medscope-browser"

REM ---- Find Google Chrome, otherwise Microsoft Edge (always on Windows) ----
set "BR="
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" set "BR=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not defined BR if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" set "BR=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if not defined BR if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" set "BR=%LocalAppData%\Google\Chrome\Application\chrome.exe"
if not defined BR if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" set "BR=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if not defined BR if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" set "BR=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"

if not defined BR (
  echo.
  echo  Could not find Google Chrome or Microsoft Edge on this computer.
  echo  Install Chrome from https://www.google.com/chrome/ and try again.
  echo.
  pause
  exit /b 1
)

if not exist "%PAGE%" (
  echo.
  echo  index.html was not found next to this file.
  echo  Keep start-kiosk.bat inside the MEDSCOPE folder.
  echo.
  pause
  exit /b 1
)

echo Starting the MEDSCOPE II screen...
start "" "%BR%" --kiosk "%PAGE%" --edge-kiosk-type=fullscreen --no-first-run --disable-pinch --overscroll-history-navigation=0 --autoplay-policy=no-user-gesture-required --disable-features=TranslateUI --disable-session-crashed-bubble --user-data-dir="%PROFILE%"
