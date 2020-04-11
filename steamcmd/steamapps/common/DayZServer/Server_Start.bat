@echo off
COLOR 02
 
:: Variables::
set watch=DayZ Standalone Dedicated Server
COLOR 02
title %watch% Watchdog
::SteamCMD Pfad
set STEAMCMD_LOCATION="C:\steamcmd"
 
:watchdog
cd %STEAMCMD_LOCATION% 
start "Steam CMD Update" /wait "steamcmd.exe" +runscript steamcmd_script.txt
start "Steam CMD Mod Update" /wait "steamcmd.exe" +runscript steamcmd_script_mods.txt

cd "C:\steamcmd\steamapps\common\DayZServer"

echo (%time%) %watch% gestartet.
start "DayZ Server" /wait "DayZServer_x64.exe" -config=serverDZ.cfg -port=2302 -dologs -adminlog -netlog -freezecheck "-mod=@RPCFramework;@Permissions-Framework;@Community-Online-Tools;@ZomBerry;@CF;"
echo (%time%) %watch% wurde geschlossen oder ist abgestürzt, Neustart wird veranlasst.
goto watchdog