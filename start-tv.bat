@echo off
REM MEDSCOPE II exhibition screen - double-click this file to start.
cd /d "%~dp0"
echo.
echo  ==========================================================
echo   MEDSCOPE II exhibition screen is starting...
echo  ==========================================================
echo.
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
  for /f "tokens=* delims= " %%b in ("%%a") do echo   Type this on the TV:  http://%%b:8000
)
echo.
echo   On this laptop you can test with:  http://localhost:8000
echo.
echo   Keep this window OPEN during the exhibition.
echo   To stop: close this window (or press Ctrl+C).
echo  ==========================================================
echo.
python -m http.server 8000
if errorlevel 1 (
  py -m http.server 8000
)
if errorlevel 1 (
  echo.
  echo  Python was not found. Install it from https://www.python.org/downloads/
  echo  and tick "Add Python to PATH" during installation.
  pause
)
