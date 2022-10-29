@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
rem https://www.dostips.com/DtTipsStringManipulation.php
rem -Q
"quickbms_4gb_files.exe" -Q -Y -f "FSD\Content\Audio\*" unreal_tournament_4_0.4.27c_paks_only.bms "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\FSD-WindowsNoEditor.pak" "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder"

echo step 1
for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio\" %%a in (.) do call :Change2 "%%~da%%~pa%%~na"
echo step 1 finished


echo Del unpacked
del /f/s/q "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder" > nul
rmdir /s/q "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder" > nul
echo deleted unpacked

set /A r=3
SET /A COUNT=0
SET /A CURRENT=1

echo counting...
for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio\" %%c in (.) do (FOR %%g IN ("%%~dc%%~pc%%~nc\*.OGG") DO SET /A COUNT=COUNT+1)
echo counted

echo ffmpeg start
REM transcode to mp3 / https://superuser.com/questions/326629/how-can-i-make-ffmpeg-be-quieter-less-verbose
for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio\" %%d in (.) do (FOR %%e IN ("%%~dd%%~pd%%~nd\*.ogg") DO (call :ISIT "%CURRENT%" & "ffmpeg.exe" -threads 8 -loglevel error -hide_banner -i "%%e" -acodec libmp3lame -q:a 0 -y "%%~de%%~pe%%~ne.mp3" & SET /A CURRENT+=1))
echo ffmpeg finish

REM delete OGG
ECHO del OGG
SET /A CURRENT=1
for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio\" %%b in (.) do (FOR %%f IN ("%%~db%%~pb%%~nb\*.OGG") DO (del "%%f" >NUL & SET /A CURRENT+=1))
echo deleted OGG

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


:ISIT
set /a _p=%1
set /a r=CURRENT%%10
if %r% EQU 0 echo %CURRENT%/%COUNT%
exit /B