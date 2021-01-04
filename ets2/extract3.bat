@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Location for extraction
SET LOCATION=%HOME%\Documents\defETS

:: Counters
SET /A COUNT=0
SET /A CURRENT=1

:: Clean any remaining files
echo Cleaning the directory
del /f/s/q %LOCATION% > nul
rmdir /s/q %LOCATION%

:: Create location
if not exist %LOCATION% MKDIR %LOCATION%

:: Location to SCS Extractor
SET EXTRACTOR="C:\Program Files (x86)\Steam\steamapps\common\Euro Truck Simulator 2\scs_extractor.exe"
:: Get the SCS Game Archive Extractor here: http://download.eurotrucksimulator2.com/scs_extractor.zip

:: Set 7z.exe location for archiving
SET ZIP="C:\Program Files\7-Zip\7z.exe"

:: Count Archives
for %%l in (*.scs) DO (IF NOT %%l == base.scs IF NOT %%l == base_cfg.scs IF NOT %%l == core.scs IF NOT %%l == effect.scs IF NOT %%l == locale.scs SET /A COUNT=COUNT+1 )

:: Extract archives
for %%a in (*.scs) DO (IF NOT %%a == base.scs IF NOT %%a == base_cfg.scs IF NOT %%a == core.scs IF NOT %%a == effect.scs IF NOT %%a == locale.scs echo ^(!CURRENT!\%COUNT%^) Unpacking %%~na & %EXTRACTOR% %%a %LOCATION%\%%~na >NUL & SET /A CURRENT+=1 )

:: Delete all non-def directories
SET /A CURRENT=1
for /D %%b in (%LOCATION%\*) do (echo ^(!CURRENT!\%COUNT%^) Clean-up %%~nb & SET /A CURRENT+=1 & (for /D %%c in (%%b\*) do (IF NOT %%~nc == def RMDIR "%%c" /s /q)) & DEL %%b\%%~nb.manifest.sii)

ECHO Zipping archive
%ZIP% a -mx=9 %LOCATION%\def %LOCATION%\*
ECHO Zipped