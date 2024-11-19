set SCRIPT_PATH=%~dp0
set PATH=%SCRIPT_PATH%\.node;%PATH%
set PLAYWRIGHT_BROWSERS_PATH=%SCRIPT_PATH%\node_modules\playwright-core\.local-browsers
call %SCRIPT_PATH%\node_modules\.bin\playwright.cmd %*