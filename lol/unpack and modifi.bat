@ECHO OFF

REM Unpack all

echo Starting to unpack
FOR /R src %%a IN (*.dlc) DO ("Tools\quickbms10.exe" -Y "Tools\giants_software33.bms" %%a "Tools\Decoding\FS19_%%~na")


REM First step of decoding l64

echo Decoding 1/2
FOR /D %%b IN (Tools\Decoding\FS19_*) DO (python Tools/l64decode.py -r %%b %%b -o)


REM Second step of decoding l64

echo Decoding 2/2
FOR /D %%c IN (Tools\Decoding\FS19_*) DO (python Tools/luajit-decompiler-master/main.py --recursive %%c --dir_out %%c --catch_asserts)

REM Rename dlcDesc

echo Renaming
FOR /R Tools\Decoding\ %%d IN (*dlcDesc.xml) DO (move %%d %%~pd\modDesc.xml)


REM Substract (DEC)10 (HEX)D from third byte of .shapes files

echo Modifying files
FOR /R Tools\Decoding\ %%e IN (*.shapes) DO (Powershell.exe -executionpolicy remotesigned -File Tools/powershellkurwaco.ps1 %%e)