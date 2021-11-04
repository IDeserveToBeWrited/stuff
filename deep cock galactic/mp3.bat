@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

SET /A COUNT=0
SET /A CURRENT=1

for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio\" %%c in (.) do (FOR %%g IN ("%%~dc%%~pc%%~nc\*.OGG") DO SET /A COUNT=COUNT+1)

REM transcode to mp3 / https://superuser.com/questions/326629/how-can-i-make-ffmpeg-be-quieter-less-verbose
for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio\" %%a in (.) do (FOR %%e IN ("%%~da%%~pa%%~na\*.OGG") DO (echo ^(!CURRENT!\%COUNT%^) & "ffmpeg.exe" -hide_banner -loglevel error -i "%%e" -acodec libmp3lame -q:a 0 -y "%%~de%%~pe%%~ne.mp3" & SET /A CURRENT+=1))

REM delete OGG
ECHO del
SET /A CURRENT=1
for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio\" %%b in (.) do (FOR %%f IN ("%%~db%%~pb%%~nb\*.OGG") DO (echo Del ^(!CURRENT!\%COUNT%^) & del "%%f" >NUL & SET /A CURRENT+=1))