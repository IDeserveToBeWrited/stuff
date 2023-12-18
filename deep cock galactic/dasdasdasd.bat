@echo off 
set /a count=10 
set /a current=20 
set /a r=current%%10 
echo t
echo %r%
echo t 
if %r% EQU 0 echo lol
if %current%%%10 EQU 0 echo lol2

set /a current=30
set /a r=current%%10 & if %r% equ 0 echo lol3