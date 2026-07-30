#!/bin/bash

# Script de lancement pour le serveur Paper - Mode Créatif
# Assurez-vous que Java 17+ est installé.

JAVA_CMD="java"
JAVA_OPTS="-Xms1G -Xmx2G -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15"

# Vérifie si un JAR est spécifié
if [ -z "$1" ]; then
    echo "Usage: $0 <paper-jar-file.jar>"
    exit 1
fi

JAR_FILE="$1"

if [ ! -f "$JAR_FILE" ]; then
    echo "Erreur: Le fichier $JAR_FILE n'existe pas."
    exit 1
fi

# Lance le serveur Paper
$JAVA_CMD $JAVA_OPTS -jar "$JAR_FILE" nogui
