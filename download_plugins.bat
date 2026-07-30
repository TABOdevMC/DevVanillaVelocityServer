@echo off
:: Script pour télécharger automatiquement les plugins pour Velocity et Paper sous Windows
:: Inclut Floodgate et GeyserMC pour le support Bedrock
:: Serveur CRACK (offline mode) avec /login
:: Assurez-vous que PowerShell est disponible (Windows 7+).

:: Couleurs pour les messages
set "RED=^<ESC>[31m"
set "GREEN=^<ESC>[32m"
set "YELLOW=^<ESC>[33m"
set "BLUE=^<ESC>[34m"
set "NC=^<ESC>[0m"

:: Remplacer les variables de couleur pour Windows
for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H# & echo on & for %%b in (1) do rem"') do (
    set "DEL=%%b"
)

:: Fonction pour afficher du texte en couleur
:ColorText
setlocal
set "color=%~1"
set "text=%~2"
<nul set /p "=." > "%~f0.tmp"
findstr /v /a:%color% /R "^$" "%~f0.tmp" nul
 del "%~f0.tmp" >nul 2>&1
endlocal
goto :eof

:: Créer les dossiers de plugins s'ils n'existent pas
call :ColorText 0x09 "Création des dossiers de plugins..."
if not exist "velocity\plugins" mkdir "velocity\plugins"
if not exist "servers\lobby\plugins" mkdir "servers\lobby\plugins"
if not exist "servers\survie\plugins" mkdir "servers\survie\plugins"
if not exist "servers\creatif\plugins" mkdir "servers\creatif\plugins"
if not exist "servers\minijeux\plugins" mkdir "servers\minijeux\plugins"

:: Télécharger les plugins pour Velocity
call :ColorText 0x09 "\n=== Téléchargement des plugins pour Velocity (Serveur CRACK) ==="
echo.

:: LuckPerms (Velocity)
call :DownloadPlugin "https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.4.100.jar" "velocity\plugins\luckperms.jar" "LuckPerms (Velocity)"

:: TabList (Velocity)
call :DownloadPlugin "https://github.com/Exceptionflug/TabList/releases/download/3.0.0/TabList-3.0.0.jar" "velocity\plugins\tab-list.jar" "TabList (Velocity)"

:: AdvancedBan (Velocity)
call :DownloadPlugin "https://github.com/Leako/AdvancedBan/releases/download/2.1.6/AdvancedBan-2.1.6.jar" "velocity\plugins\advancedban.jar" "AdvancedBan (Velocity)"

:: VelocityAuth (Velocity) - Pour le /login
call :DownloadPlugin "https://github.com/Patbox/VelocityAuth/releases/download/2.0.0/VelocityAuth-2.0.0.jar" "velocity\plugins\velocityauth.jar" "VelocityAuth (Velocity)"

:: RedisBungee (Velocity)
call :DownloadPlugin "https://github.com/ImaginaryDevelopment/RedisBungee/releases/download/1.0.0/RedisBungee-1.0.0.jar" "velocity\plugins\redisbungee.jar" "RedisBungee (Velocity)"

:: Floodgate (Velocity) - Support Bedrock
call :DownloadPlugin "https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/bootstrap/velocity/build/libs/floodgate-velocity-2.2.1.jar" "velocity\plugins\floodgate.jar" "Floodgate (Velocity)"

:: GeyserMC (Velocity) - Alternative à Floodgate pour Bedrock
call :DownloadPlugin "https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/velocity/build/libs/geyser-velocity-2.2.0-SNAPSHOT.jar" "velocity\plugins\geyser.jar" "GeyserMC (Velocity)"

:: Télécharger les plugins pour le Lobby
call :ColorText 0x09 "\n=== Téléchargement des plugins pour le Lobby ==="
echo.

:: EssentialsX (Lobby)
call :DownloadPlugin "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/EssentialsX-2.20.1.jar" "servers\lobby\plugins\essentials.jar" "EssentialsX (Lobby)"

:: LuckPerms (Lobby)
call :DownloadPlugin "https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.4.100.jar" "servers\lobby\plugins\luckperms.jar" "LuckPerms (Lobby)"

:: Télécharger les plugins pour les autres serveurs (optionnel)
call :ColorText 0x09 "\n=== Téléchargement des plugins pour les autres serveurs ==="
echo.

:: LuckPerms pour Survie, Créatif, Mini-Jeux
for %%s in (survie creatif minijeux) do (
    call :DownloadPlugin "https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.4.100.jar" "servers\%%s\plugins\luckperms.jar" "LuckPerms (%%s)"
)

call :ColorText 0x0A "\n=== Tous les plugins ont été téléchargés ! ==="
echo.
echo Pour un serveur CRACK avec support Bedrock :
echo 1. Assurez-vous que online_mode = false dans velocity.toml
echo 2. Floodgate et GeyserMC sont dans velocity\plugins\
echo 3. Le port 19132 est ouvert sur votre serveur
echo 4. VelocityAuth est configuré en mode BOTH ou LOGIN
echo.
echo Les joueurs Java et Bedrock devront utiliser /login ou /register
echo.
echo Vous pouvez maintenant lancer les serveurs avec start_all.bat
pause
goto :eof

:: Fonction pour télécharger un plugin
:DownloadPlugin
setlocal
set "url=%~1"
set "destination=%~2"
set "plugin_name=%~3"

:: Vérifier si le fichier existe déjà
if exist "%destination%" (
    call :ColorText 0x0E "Le plugin %plugin_name% existe déjà dans %destination%. Suppression..."
    del "%destination%"
)

:: Télécharger le plugin avec PowerShell
call :ColorText 0x09 "Téléchargement de %plugin_name%..."
powershell -Command "(New-Object Net.WebClient).DownloadFile('%url%', '%destination%')"

:: Vérifier si le téléchargement a réussi
if exist "%destination%" (
    call :ColorText 0x0A "Plugin %plugin_name% téléchargé avec succès !"
) else (
    call :ColorText 0x0C "Échec du téléchargement de %plugin_name%."
)

endlocal
goto :eof
