@echo off 
:::::::::::::::::::::::::::::::::::::::::::::::
:: Dies ist die Batch File zum Start des DayZ Standalone Server unter Windows
:: v2.05
:::::::::::::::::::::::::::::::::::::::::::::::
:: Bitte bearbeite deine Mod Liste in der Datei modlist.txt, welche sich im Grundpfad von Steam oder SteamCMD befinden sollte. Sollte diese nicht vorhanden sein, musst du diese anlegen.
:: Die Script Dateien aus v1.XX werden nicht mehr benötigt.
:::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::
:: Allgemeine Variablen und Globale Einstellungen
:::::::::::::::::::::::::::::::::::::::::::::::
set watch=DayZ Standalone Dedicated Server
COLOR 02
title %watch% Watchdog
setlocal EnableDelayedExpansion
:::::::::::::::::::::::::::::::::::::::::::::::
::Bitte gib die entsprechende Ordner und Daten in den folgenden Variablen an!
:::::::::::::::::::::::::::::::::::::::::::::::
set MOD_LIST=(C:\steamcmd\modlist.txt)
set STEAM_WORKSHOP=C:\steamcmd\steamapps\workshop\content\221100
set DAYZ-SA_SERVER_LOCATION="C:\steamcmd\steamapps\common\DayZServer"
set STEAMCMD_LOCATION="C:\steamcmd"
set STEAM_USER=USERNAME
set STEAM_PWD=PASSWORT

:watchdog
cd %STEAMCMD_LOCATION% 
::Update DayZ Server Dateien
steamcmd.exe +login %STEAM_USER% %STEAM_PWD% +app_update 223350 +quit

:::::::::::::::::::::::::::::::::::::::::::::::
::Update DayZ Server Mod Dateien
:::::::::::::::::::::::::::::::::::::::::::::::
for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do steamcmd.exe +login %STEAM_USER% %STEAM_PWD% +workshop_download_item 221100 "%%g" +quit

:::::::::::::::::::::::::::::::::::::::::::::::
::Kopieren der Mod Dateien in den Server Ordner und kopiert die Key Dateien in den richtigen Ordner
:::::::::::::::::::::::::::::::::::::::::::::::
@ for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do robocopy "%STEAM_WORKSHOP%\%%g" "%DAYZ-SA_SERVER_LOCATION%\%%h" *.* /mir
@ for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do forfiles /p "%DAYZ-SA_SERVER_LOCATION%\%%h" /m *.bikey /s /c "cmd /c copy @path %DAYZ-SA_SERVER_LOCATION%\keys"

:::::::::::::::::::::::::::::::::::::::::::::::
::Definiere welche Mods geladen werden sollen
:::::::::::::::::::::::::::::::::::::::::::::::
set "MODS_TO_LOAD="
for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do (
set "MODS_TO_LOAD=!MODS_TO_LOAD!%%h;"
)

:::::::::::::::::::::::::::::::::::::::::::::::
::Start DayZ Server
:::::::::::::::::::::::::::::::::::::::::::::::
cd %DAYZ-SA_SERVER_LOCATION%

echo (%time%) %watch% gestartet.
start "DayZ Server" /wait "DayZServer_x64.exe" -config=serverDZ.cfg -port=2302 -dologs -adminlog -netlog -freezecheck "-mod=%MODS_TO_LOAD%"
echo (%time%) %watch% wurde geschlossen oder ist abgestuerzt, Neustart wird veranlasst.
goto watchdog

:::::::::::::::::::::::::::::::::::::::::::::::
:: Credits:
:: u/OlivGaming via Reddit, hier habe ich den Bereich der Modliste übernommen und diese für das Mod-Update und Start Parameter verwendet.
:::::::::::::::::::::::::::::::::::::::::::::::