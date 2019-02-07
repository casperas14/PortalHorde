@echo Started: %date% %time%
cd ..
git pull | findstr /C:"Already up to date."
IF %errorlevel%==0 GOTO:EOF
echo Continuing ....
cd auto
.\build_poc
@echo Builds Complete: %date% %time%
.\itch.bat