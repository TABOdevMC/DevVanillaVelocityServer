#!/bin/bash

# Script pour télécharger automatiquement les plugins pour Velocity et Paper
# Inclut Floodgate pour le support Bedrock
# Assurez-vous que wget ou curl est installé.

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Vérifier si wget est installé
if ! command -v wget &> /dev/null; then
    echo -e "${RED}Erreur: wget n'est pas installé. Installez-le avec 'sudo apt install wget' (Debian/Ubuntu) ou 'sudo yum install wget' (CentOS/RHEL).${NC}"
    exit 1
fi

# Fonction pour télécharger un fichier
download_plugin() {
    local url=$1
    local destination=$2
    local plugin_name=$3
    
    if [ -f "$destination" ]; then
        echo -e "${YELLOW}Le plugin $plugin_name existe déjà dans $destination. Suppression...${NC}"
        rm -f "$destination"
    fi
    
    echo -e "${BLUE}Téléchargement de $plugin_name...${NC}"
    wget -q --show-progress "$url" -O "$destination"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Plugin $plugin_name téléchargé avec succès !${NC}"
    else
        echo -e "${RED}Échec du téléchargement de $plugin_name.${NC}"
    fi
}

# Créer les dossiers de plugins s'ils n'existent pas
mkdir -p velocity/plugins
mkdir -p servers/lobby/plugins
mkdir -p servers/survie/plugins
mkdir -p servers/creatif/plugins
mkdir -p servers/minijeux/plugins

# Télécharger les plugins pour Velocity
echo -e "\n${BLUE}=== Téléchargement des plugins pour Velocity ===${NC}\n"

# LuckPerms (Velocity)
download_plugin "https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.4.100.jar" \
    "velocity/plugins/luckperms.jar" \
    "LuckPerms (Velocity)"

# TabList (Velocity)
download_plugin "https://github.com/Exceptionflug/TabList/releases/download/3.0.0/TabList-3.0.0.jar" \
    "velocity/plugins/tab-list.jar" \
    "TabList (Velocity)"

# AdvancedBan (Velocity)
download_plugin "https://github.com/Leako/AdvancedBan/releases/download/2.1.6/AdvancedBan-2.1.6.jar" \
    "velocity/plugins/advancedban.jar" \
    "AdvancedBan (Velocity)"

# VelocityAuth (Velocity)
download_plugin "https://github.com/Patbox/VelocityAuth/releases/download/2.0.0/VelocityAuth-2.0.0.jar" \
    "velocity/plugins/velocityauth.jar" \
    "VelocityAuth (Velocity)"

# RedisBungee (Velocity)
download_plugin "https://github.com/ImaginaryDevelopment/RedisBungee/releases/download/1.0.0/RedisBungee-1.0.0.jar" \
    "velocity/plugins/redisbungee.jar" \
    "RedisBungee (Velocity)"

# Floodgate (Velocity) - Support Bedrock
download_plugin "https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/bootstrap/velocity/build/libs/floodgate-velocity-2.2.1.jar" \
    "velocity/plugins/floodgate.jar" \
    "Floodgate (Velocity)"

# Télécharger les plugins pour le Lobby
echo -e "\n${BLUE}=== Téléchargement des plugins pour le Lobby ===${NC}\n"

# EssentialsX (Lobby)
download_plugin "https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/EssentialsX-2.20.1.jar" \
    "servers/lobby/plugins/essentials.jar" \
    "EssentialsX (Lobby)"

# LuckPerms (Lobby)
download_plugin "https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.4.100.jar" \
    "servers/lobby/plugins/luckperms.jar" \
    "LuckPerms (Lobby)"

# Télécharger les plugins pour les autres serveurs (optionnel)
echo -e "\n${BLUE}=== Téléchargement des plugins pour les autres serveurs ===${NC}\n"

# LuckPerms pour Survie, Créatif, Mini-Jeux
for server in survie creatif minijeux; do
    download_plugin "https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.4.100.jar" \
        "servers/$server/plugins/luckperms.jar" \
        "LuckPerms ($server)"
done

echo -e "\n${GREEN}=== Tous les plugins ont été téléchargés ! ===${NC}\n"
echo "Pour activer le support Bedrock, assurez-vous que :"
echo "1. Floodgate est dans velocity/plugins/"
echo "2. Le port 19132 est ouvert sur votre serveur"
echo "3. velocity.toml a la configuration Bedrock activée"
echo ""
echo "Vous pouvez maintenant lancer les serveurs avec ./start_all.sh"
