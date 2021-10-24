@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
rem https://www.dostips.com/DtTipsStringManipulation.php



rem title Command Repeating Batch File
echo unpack
REM "quickbms.exe" -Y unreal_tournament_4.bms "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\FSD-WindowsNoEditor.pak" "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder"
rem ale potwor xD
rem for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio\" %%f in (.) do echo folder in %%~df%%~pf%%~nf & echo . & echo folder out C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\ 

rem & python uexplode.py %%~df%%~pf%%~nf

rem 
rem for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio\" %%g in (.) do call :Change %%~dg%%~pg%%~ng
set chng=C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio\Characters\Voices\Dwarves\Dwarf_01\
set chng=%chng:C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio=%
set chng=C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio%chng%
echo %chng%
echo loop
rem cos nie dziala
for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio\" %%a in (.) do call :Change2 "%%~da%%~pa%%~na"

rem for /r "C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio\" %%a in (.) do set lol2=%%~da%%~pa%%~na & call :Change temp lol2 & echo nowy & echo|set /p=!temp!
rem & call :Change lol lol2 % mkdir %lol% & echo lol %lol%
endlocal
goto :EOF
rem https://stackoverflow.com/questions/3216475/batch-remove-a-string-from-a-string
:Sub
set str=%*
set str=%str:C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio=%
echo %str%
exit /B


rem sam xD
:Change <resultVar> <stringVar>
setlocal EnableDelayedExpansion
set^ chng=!%~2!
set chng=%chng:C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio=%
set chng=C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio!chng!
SET _result=%chng%
echo debug !chng!
exit /B


:Change2
set _chng=%1
rem echo 1 %1
set _chng=%_chng:C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder\FSD\Content\Audio=%
set _chng=%_chng:"=%
set _chng=C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\FSD\Content\Paks\Nowy folder2\FSD\Content\Audio!_chng!
SET _result=!_chng!
mkdir "!_chng!"
python uexplode.py %1 "!_chng!"
rem echo debug !_chng!
exit /B


rem https://stackoverflow.com/questions/5837418/how-do-you-get-the-string-length-in-a-batch-file
REM ********* function *****************************
REM :strlen <resultVar> <stringVar>
REM (   
    REM setlocal EnableDelayedExpansion
    REM (set^ tmp=!%~2!)
    REM if defined tmp (
        REM set "len=1"
        REM for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
            REM if "!tmp:~%%P,1!" NEQ "" ( 
                REM set /a "len+=%%P"
                REM set "tmp=!tmp:~%%P!"
            REM )
        REM )
    REM ) ELSE (
        REM set len=0
    REM )
REM )
REM ( 
    REM endlocal
    REM set "%~1=%len%"
    REM exit /b
REM )