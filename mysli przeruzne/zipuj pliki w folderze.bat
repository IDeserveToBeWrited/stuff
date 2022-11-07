@echo off
SET ZIP="C:\Program Files\7-Zip\7z.exe"
for /r %%a in (*.mkv) do %ZIP% a -mx0 -pTAJNEHASLO %%~na.zip %%a 