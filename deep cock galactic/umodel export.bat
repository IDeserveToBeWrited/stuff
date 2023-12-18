@echo off

set DRG_PATH="C:\Program Files (x86)\Steam\steamapps\common\Deep Rock Galactic\"
set EXPORT_PATH="C:\Users\doode\Desktop\DRG Export"

umodel -path=%DRG_PATH% -out=%EXPORT_PATH% -export FSD/Content/Audio/*