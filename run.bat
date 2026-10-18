@echo off
chcp 65001 >nul
rem music-geshizhuanhuan Windows 启动器（网页版 / 命令行 双模式）
rem 网页版:  run.bat web                 -> 自动打开 http://127.0.0.1:8686
rem 命令行:  run.bat <文件或目录> [-o 输出目录] [--format mp3|flac|m4a|wav|ogg]
cd /d "%~dp0"

rem 首次运行自动创建虚拟环境并安装依赖
if not exist ".venv\Scripts\python.exe" (
  echo [music-geshizhuanhuan] 首次运行：创建虚拟环境并安装依赖...
  where py >nul 2>nul && (py -3 -m venv .venv) || (python -m venv .venv)
  ".venv\Scripts\python" -m pip install -q --upgrade pip
  ".venv\Scripts\python" -m pip install -q -r requirements.txt
)

rem 用 goto 而不是 if(...) 块：cmd 在括号块里会提前展开 %1，导致 shift 失效
if /i "%~1"=="web" goto :run_web
".venv\Scripts\python" unlocker.py %*
goto :eof

:run_web
shift
".venv\Scripts\python" web\server.py %1 %2 %3 %4 %5 %6 %7 %8 %9
goto :eof
