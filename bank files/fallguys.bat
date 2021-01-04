@echo off
title Command Repeating Batch File
echo unpack
FOR /R "C:\Program Files (x86)\Steam\steamapps\common\Fall Guys\FallGuys_client_game_Data\StreamingAssets" %%b IN (*.bank) DO ("quickbms.exe" -Y Script.bms "%%b" "C:\Users\doode\Desktop\fallguys2\%%~nb")
echo copy
for /D %%c in ("C:\Users\doode\Desktop\fallguys2\*") do (copy fmod_extr.exe "%%c" & copy fmodex.dll "%%c" & copy fmodL.dll "%%c" & copy fsb_aud_extr.exe "%%c")
echo unaudio
for /D %%d in ("C:\Users\doode\Desktop\fallguys2\*") do (cd %%d & fsb_aud_extr.exe 00000000.fsb)
echo cleanup
for /d %%e in ("C:\Users\doode\Desktop\fallguys2\*") do (del %%e\fmod_extr.exe & del %%e\fmodex.dll & del %%e\fmodL.dll & del %%e\fsb_aud_extr.exe & del %%e\00000000.fsb)
echo done
pause