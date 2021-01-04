@echo off
set HERE=%CD%
set INPUT=C:\Program Files (x86)\Steam\steamapps\common\Euro Truck Simulator 2\b\sound\
set OUTPUT=C:\Users\doode\Desktop\ets


REM For the folders in base\sound folder - let's call them category
for /d %%h in ("%INPUT%*") do call :Stuff "%%h"

REM After that go further
goto Test

REM QuickBMS the .bank files to the OUTPUT\category folder
:Stuff
REM Variable m to the filename (without extension)
set m=%~n1
REM For the base\sound\category folders
FOR /R %1 %%G IN (*.bank) DO (
	REM Unpack file with QuickBMS
	"quickbms.exe" -Q -Y Script.bms "%%G" "%OUTPUT%\%m%"
	REM And rename it to the original filename, as QuickBMS outputs it as 00000000.fsb
	move %OUTPUT%\%m%\00000000.fsb %OUTPUT%\%m%\%%~nG.fsb > nul
	REM This leaves OUTPUT\category\filename.fsb file
)
GOTO:EOF

REM This will 
:Test
REM For category folders in OUTPUT
for /D %%d in ("%OUTPUT%\*") do call :Unaudio "%%d"
goto End

:Unaudio
REM Set variable to a path to OUTPUT\category
set l=%~1


REM For *.fsb files in OUTPUT\category folder
For /R %1 %%J in (*.fsb) do (
	REM Go to category folder
	cd %l%
	REM Make a folder for the fsb file
	mkdir %%~nJ > nul
	REM Move fsb file to fsb folder
	move %%J %%~nJ\%%~nJ.fsb > nul
	REM Copy extractor files
	call :Copy "%%~dJ%%~pJ%%~nJ"
	REM Go to fsb folder
	cd %%~nJ
	echo Extracting %~n1\%%~nJ.fsb file to %~n1\%%~nJ
	REM Extract fsb file
	fsb_aud_extr.exe %%~nJ.fsb > nul
	REM Delete extractor and fsb files
	call :Delete "%l%\%%~nJ" "%%~nJ.fsb"
)
GOTO:EOF

REM It copies extractor files
:Copy
copy "C:\Users\doode\Downloads\bank files\fmod_extr.exe" "%1%" > nul
copy "C:\Users\doode\Downloads\bank files\fmodex.dll" "%1%" > nul
copy "C:\Users\doode\Downloads\bank files\fmodL.dll" "%1%" > nul
copy "C:\Users\doode\Downloads\bank files\fsb_aud_extr.exe" "%1%" > nul
GOTO:EOF

REM Deletes extractor files and fsb file
:Delete
del "%1%\fmod_extr.exe" > nul
del "%1%\fmodex.dll" > nul
del "%1%\fmodL.dll" > nul
del "%1%\fsb_aud_extr.exe" > nul
del "%~1\%~2" > nul
GOTO:EOF
:End
echo done
cd %HERE%