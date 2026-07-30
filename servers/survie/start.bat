@echo off
:: Script de lancement pour le serveur Paper - Survie (Windows)
:: Assurez-vous que Java 17+ est installé.

setlocal

:: Configuration Java
set JAVA_CMD=java
set JAVA_OPTS=-Xms1G -Xmx2G -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15

:: Vérifier si un JAR est spécifié
if "%~1"=="" (
    echo Usage: %~nx0 ^<paper-jar-file.jar^>
    pause
    exit /b 1
)

set JAR_FILE=%~1

:: Vérifier si le fichier JAR existe
if not exist "%JAR_FILE%" (
    echo Erreur: Le fichier %JAR_FILE% n'existe pas.
    pause
    exit /b 1
)

:: Lancer le serveur Paper
echo Lancement du serveur Survie avec %JAR_FILE%...
%JAVA_CMD% %JAVA_OPTS% -jar "%JAR_FILE%" nogui

endlocal
