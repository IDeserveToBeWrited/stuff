@echo off
REM First step of decoding l64

echo Decoding 1/2
FOR /D %%b IN (Tools\Decoding\FS19_*) DO (python Tools/l64decode.py -r %%b %%b -o)


REM Second step of decoding l64

echo Decoding 2/2
FOR /D %%c IN (Tools\Decoding\FS19_*) DO (python Tools/luajit-decompiler-master/main.py --recursive %%c --dir_out %%c --catch_asserts)