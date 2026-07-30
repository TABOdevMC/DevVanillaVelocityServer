@echo off
:: Script pour lancer tous les serveurs (Velocity + 4 sous-serveurs Paper) sous Windows
:: Assurez-vous que Java 17+ est installé et que les JARs sont en place.

:: Couleurs pour les messages (Windows 10+)
set "RED=^<ESC^[31m"
set "GREEN=^<ESC^[32m"
set "YELLOW=^<ESC^[33m"
set "BLUE=^<ESC^[34m"
set "MAGENTA=^<ESC^[35m"
set "NC=^<ESC^[0m"

:: Remplacer les variables de couleur pour Windows
for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H# & echo on & for %%b in (1) do rem"') do (
    set "DEL=%%b"
)
call :ColorText 0x0C "Lancement des serveurs DevVanilla..." 
call :ColorText 0x0A "========================================" 
echo.

:: Fonction pour vérifier si un port est utilisé
:CheckPort
setlocal
set "port=%~1"
netstat -ano | findstr ":%port% " >nul 2>&1
if %errorlevel% equ 0 (
    endlocal
    exit /b 0
) else (
    endlocal
    exit /b 1
)

:: Fonction pour lancer un serveur dans une nouvelle fenêtre
:LaunchServer
setlocal
set "name=%~1"
set "dir=%~2"
set "jar=%~3"
set "port=%~4"
set "color=%~5"

:: Vérifier si le fichier JAR existe
if not exist "%dir%\%jar%" (
    call :ColorText 0x0C "Erreur: Le fichier %dir%\%jar% n'existe pas."
    endlocal
    exit /b 1
)

:: Vérifier si le port est déjà utilisé
call :CheckPort %port%
if %errorlevel% equ 0 (
    call :ColorText 0x0E "Le port %port% est déjà utilisé. Le serveur %name% est peut-être déjà lancé."
    endlocal
    exit /b 0
)

:: Lancer le serveur dans une nouvelle fenêtre
call :ColorText %color% "Lancement du serveur %name% sur le port %port%..."
start "%name%" cmd /k "cd /d %dir% && start.bat %jar%"

:: Attendre 2 secondes pour que le serveur démarre
timeout /t 2 >nul

:: Vérifier si le port est maintenant utilisé
call :CheckPort %port%
if %errorlevel% equ 0 (
    call :ColorText 0x0A "Serveur %name% lancé avec succès!"
) else (
    call :ColorText 0x0C "Échec du lancement du serveur %name%. Vérifiez les logs."
)

endlocal
goto :eof

:: Fonction pour afficher du texte en couleur (Windows)
:ColorText
setlocal
set "color=%~1"
set "text=%~2"
<nul set /p "=." > "%~f0.tmp"
findstr /v /a:%color% /R "^$" "%~f0.tmp" nul
 del "%~f0.tmp" >nul 2>&1
endlocal
goto :eof

:: Lancer les sous-serveurs Paper
call :LaunchServer "Lobby" "servers\lobby" "paper.jar" "25568" "0x0D"
call :LaunchServer "Survie" "servers\survie" "paper.jar" "25565" "0x0A"
call :LaunchServer "Créatif" "servers\creatif" "paper.jar" "25566" "0x09"
call :LaunchServer "MiniJeux" "servers\minijeux" "paper.jar" "25567" "0x0E"

:: Attendre 5 secondes pour que les sous-serveurs démarrent
echo.
call :ColorText 0x0E "Attente de 5 secondes pour que les sous-serveurs démarrent..."
timeout /t 5 >nul

:: Lancer Velocity
call :LaunchServer "Velocity" "velocity" "velocity.jar" "25577" "0x0C"

echo.
call :ColorText 0x0E "Tous les serveurs ont été lancés!"
echo.
echo Utilisez les fenêtres pop-up pour accéder à la console de chaque serveur.
echo Pour fermer un serveur, fermez simplement sa fenêtre.
echo.
pause
