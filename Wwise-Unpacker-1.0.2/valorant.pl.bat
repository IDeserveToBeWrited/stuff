FOR %%f IN ("Game Files\*.PCK") DO (DEL "%%f")
FOR %%g IN ("Game Files\*.BNK") DO (DEL "%%g")
FOR %%h IN ("Tools\Decoding\*.WAV") DO (DEL "%%h")

Tools\quickbms10.exe "Tools\unreal_tournament_4.bms" "C:\Riot Games\VALORANT\live\ShooterGame\Content\Paks\pl_PL_Audio-WindowsClient.pak" "Game Files"

FOR %%a IN ("Game Files\*Events*.PCK") DO ("Tools\quickbms.exe" "Tools\wavescan.bms" "%%a" "Tools\Decoding")
REM FOR %%b IN ("Game Files\*.BNK") DO ("Tools\bnkextr.exe" "%%b" & MOVE *.wav "Tools\Decoding")

FOR %%c IN (Tools\Decoding\*.WAV) DO ("Tools\ww2ogg.exe" "%%c" --pcb Tools\packed_codebooks_aoTuV_603.bin & DEL "%%c")
FOR %%d IN (Tools\Decoding\*.OGG) DO ("Tools\revorb.exe" "%%d" & MOVE "%%d" "OGG")
FOR %%e IN (OGG\*.OGG) DO ("Tools\ffmpeg.exe" -i "%%e" -acodec libmp3lame -q:a 0 -y "MP3\%%~ne.mp3")