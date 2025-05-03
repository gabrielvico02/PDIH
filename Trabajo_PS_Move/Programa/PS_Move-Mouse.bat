@echo off
cls
echo Iniciando entorno completo para PS Move como ratón...

REM --- Iniciar PSMoveServiceAdmin ---
start "" /min "C:\Users\gabri\OneDrive\Escritorio\Trabajo_PDIH\bin\PSMoveServiceAdmin.exe"
timeout /t 2 >nul

REM --- Lanzar PSMoveFreepieBridge ---
start "" "C:\Users\gabri\OneDrive\Escritorio\Trabajo_PDIH\PSMoveFreepieBridge.exe"
timeout /t 3 >nul

REM --- Simular entrada de parámetros con PowerShell + forzar foco por título ---
powershell -NoProfile -Command ^
"$wshell = New-Object -ComObject WScript.Shell; ^
Start-Sleep -Seconds 1; ^
:waitLoop ^
if (-not $wshell.AppActivate('PSMoveFreepieBridge')) { Start-Sleep -Milliseconds 500; goto waitLoop }; ^
Start-Sleep -Milliseconds 500; ^
$wshell.SendKeys('2{ENTER}'); Start-Sleep -Milliseconds 300; ^
$wshell.SendKeys('1{ENTER}'); Start-Sleep -Milliseconds 300; ^
$wshell.SendKeys('0{ENTER}'); Start-Sleep -Milliseconds 300; ^
$wshell.SendKeys('y{ENTER}'); Start-Sleep -Milliseconds 300; ^
$wshell.SendKeys('2{ENTER}'); Start-Sleep -Milliseconds 300; ^
$wshell.SendKeys('-1{ENTER}');"

REM --- Iniciar FreePIE con script cargado ---
start "" "C:\Program Files (x86)\FreePIE\FreePIE.exe" "C:\Users\gabri\OneDrive\Escritorio\Trabajo_PDIH\movimiento_mouse.py"
timeout /t 5 >nul

REM --- Simular F5 en FreePIE para ejecutar script ---
powershell -NoProfile -Command ^
"$wshell = New-Object -ComObject WScript.Shell; ^
Start-Sleep -Milliseconds 500; ^
$wshell.AppActivate('FreePIE'); ^
Start-Sleep -Milliseconds 500; ^
$wshell.SendKeys('{F5}');"

exit
