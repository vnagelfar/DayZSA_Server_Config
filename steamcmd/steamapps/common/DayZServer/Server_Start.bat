@echo off
cls
 
set watch=DayZ Server

title %watch% Watchdog
 
:watchdog
cd "C:\steamcmd" 
start "Steam CMD Update" /wait "steamcmd.exe" +runscript steamcmd_script.txt

cd "C:\steamcmd\steamapps\common\DayZServer"

echo (%time%) %watch% gestartet.
start "DayZ Server" /wait "DayZServer_x64.exe" -config=serverDZ.cfg -port=2302 -dologs -adminlog -netlog -freezecheck "-mod=@RPCFramework;@Permissions-Framework;@Community-Online-Tools;"
echo (%time%) %watch% wurde geschlossen oder ist abgestuerzt, Neustart wird veranlasst.
goto watchdog
