@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
rem https://www.dostips.com/DtTipsStringManipulation.php

"quickbms_4gb_files.exe" -Y -f "FSD\Content\Audio\*" unreal_tournament_4.bms "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\FSD-WindowsNoEditor.pak" "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder"


for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio\" %%a in (.) do call :Change2 "%%~da%%~pa%%~na"

del /f/s/q "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder" > nul
rmdir /s/q "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder"

GOTO :EOF

:Change2
set _chng=%1
set _chng=%_chng:C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio=%
set _chng=%_chng:"=%
set _chng=C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio!_chng!
SET _result=!_chng!
mkdir "!_chng!"
python uexplode.py %1 "!_chng!"
exit /B