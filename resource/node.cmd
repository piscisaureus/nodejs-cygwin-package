@echo off
setlocal

set p=%~dp0
set s=%~f1
set path=%p%bin\;%path%

if not "%s%"=="" goto :script
"%p%node\bin\node.exe"
goto :end

:script
for /f "delims=:" %%i in ('cygpath "%s%"') do "%p%node\bin\node.exe" "%%i"
goto :end

:end
echo.
echo node has exited.
pause

endlocal