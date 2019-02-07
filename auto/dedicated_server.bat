@echo Started: %date% %time%
SET _project=Ah
cd %_project%
git pull | findstr /C:"Already up to date."
REM IF %errorlevel%==0 GOTO:EOF
echo Continuing ....
"C:\Program Files\Epic Games\UE_4.21\Engine\Binaries\Win64\UE4Editor" "C:/Dev/%_project%/%_project%.uproject" /Game/Maps/start -server -game -log