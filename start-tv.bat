@echo off
REM MEDSCOPE II exhibition screen - double-click this file to start.
setlocal
cd /d "%~dp0"

REM ---- Find Python (works even if "Add to PATH" was not ticked) ----
set "PYEXE="
set "PYARG="
where py >nul 2>nul
if not errorlevel 1 (
  py -3 -c "import sys" >nul 2>nul
  if not errorlevel 1 (
    set "PYEXE=py"
    set "PYARG=-3"
  )
)
if not defined PYEXE (
  python -c "import sys" >nul 2>nul
  if not errorlevel 1 set "PYEXE=python"
)
if not defined PYEXE for /d %%d in ("%LocalAppData%\Programs\Python\Python3*") do if exist "%%~d\python.exe" set "PYEXE=%%~d\python.exe"
if not defined PYEXE for /d %%d in ("%LocalAppData%\Python\pythoncore-3*") do if exist "%%~d\python.exe" set "PYEXE=%%~d\python.exe"
if not defined PYEXE for /d %%d in ("%ProgramFiles%\Python3*") do if exist "%%~d\python.exe" set "PYEXE=%%~d\python.exe"
if not defined PYEXE for /d %%d in ("C:\Python3*") do if exist "%%~d\python.exe" set "PYEXE=%%~d\python.exe"

if not defined PYEXE (
  echo.
  echo  ==========================================================
  echo   Python is NOT installed on this laptop yet.
  echo.
  echo   1. Go to  https://www.python.org/downloads/windows/
  echo   2. Download "Windows installer (64-bit)"  - the .exe file
  echo   3. Run it, tick "Add python.exe to PATH", click Install Now
  echo   4. Double-click start-tv.bat again
  echo  ==========================================================
  echo.
  pause
  exit /b 1
)

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
echo   To stop: close this window.
echo  ==========================================================
echo.
"%PYEXE%" %PYARG% -m http.server 8000
echo.
echo  The screen server stopped. If you see an error above, take a photo
echo  of this window and send it for help.
pause
