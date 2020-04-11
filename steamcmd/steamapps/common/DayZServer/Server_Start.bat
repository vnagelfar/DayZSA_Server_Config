@echo off
cls
 
set watch=DayZ Server

title %watch% Watchdog
 
cd "C:\Program Files (x86)\Steam\steamapps\common\DayZServer"

:watchdog
echo (%time%) %watch% gestartet.
start "DayZ Server" /wait "DayZServer_x64.exe" -config=serverDZ.cfg -port=2302 -dologs -adminlog -netlog -freezecheck "-mod=@RPCFramework;@Permissions-Framework;@Community-Online-Tools;"
echo (%time%) %watch% wurde geschlossen oder ist abgestürzt, Neustart wird veranlasst.
goto watchdog