@echo off
rem music-geshizhuanhuan launcher (web / cli) - ASCII only, CRLF, do not add non-ASCII here
cd /d "%~dp0"

if not exist ".venv\Scripts\python.exe" (
  echo [music-geshizhuanhuan] first run: creating venv and installing deps...
  where py >nul 2>nul && (py -3 -m venv .venv) || (python -m venv .venv)
  ".venv\Scripts\python" -m pip install -q --upgrade pip
  ".venv\Scripts\python" -m pip install -q -r requirements.txt
)

if /i "%~1"=="web" goto :run_web
".venv\Scripts\python" unlocker.py %*
goto :eof

:run_web
shift
".venv\Scripts\python" web\server.py %1 %2 %3 %4 %5 %6 %7 %8 %9
goto :eof
