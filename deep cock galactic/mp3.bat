@echo off

REM transcode to mp3 / https://superuser.com/questions/326629/how-can-i-make-ffmpeg-be-quieter-less-verbose
for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio\" %%a in (.) do (FOR %%e IN ("%%~da%%~pa%%~na\*.OGG") DO "ffmpeg.exe" -hide_banner -loglevel error -i "%%e" -acodec libmp3lame -q:a 0 -y "%%~de%%~pe%%~ne.mp3")

REM delete OGG
for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio\" %%b in (.) do (FOR %%f IN ("%%~db%%~pb%%~nb\*.OGG") DO del "%%f" >NUL)