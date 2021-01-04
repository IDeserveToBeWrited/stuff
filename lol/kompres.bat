@echo off
FOR /D %%f IN (Tools\Decoding\FS19_*) DO (Tools\7z.exe a -tzip -mx=5 -x!*.l64 -x!*.l32 %%~nf %%~ff\*)
FOR %%h in (*.zip) DO (move %%h "C:\Users\doode\Documents\My Games\FarmingSimulator2019\mods\%%~nh.zip")