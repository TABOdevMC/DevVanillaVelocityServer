#!/bin/bash

# Script pour lancer tous les serveurs (Velocity + 4 sous-serveurs Paper)
# Assurez-vous que Java 17+ est installé et que les JARs sont en place.

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Fonction pour vérifier si un port est utilisé
is_port_in_use() {
    if command -v netstat >/dev/null 2>&1; then
        netstat -tuln | grep ":$1 " >/dev/null 2>&1
    elif command -v ss >/dev/null 2>&1; then
        ss -tuln | grep ":$1 " >/dev/null 2>&1
    else
        return 1
    fi
    return $?
}

# Fonction pour lancer un serveur dans un screen
launch_server() {
    local name=$1
    local dir=$2
    local jar=$3
    local port=$4
    local color=$5

    if [ ! -f "$dir/$jar" ]; then
        echo -e "${RED}Erreur: Le fichier $dir/$jar n'existe pas.${NC}"
        return 1
    fi

    if is_port_in_use "$port"; then
        echo -e "${YELLOW}Le port $port est déjà utilisé. Le serveur $name est peut-être déjà lancé.${NC}"
        return 0
    fi

    echo -e "${color}Lancement du serveur $name sur le port $port...${NC}"
    cd "$dir" || return 1
    screen -dmS "$name" bash -c "$dir/start.sh $jar"
    sleep 2
    
    if is_port_in_use "$port"; then
        echo -e "${GREEN}Serveur $name lancé avec succès!${NC}"
    else
        echo -e "${RED}Échec du lancement du serveur $name. Vérifiez les logs.${NC}"
    fi
}

# Vérifier si screen est installé
if ! command -v screen >/dev/null 2>&1; then
    echo -e "${RED}Erreur: 'screen' n'est pas installé. Installez-le avec 'sudo apt install screen' (Debian/Ubuntu) ou 'sudo yum install screen' (CentOS/RHEL).${NC}"
    exit 1
fi

# Lancer les sous-serveurs Paper
launch_server "Lobby" "servers/lobby" "paper.jar" "25568" "$MAGENTA"
launch_server "Survie" "servers/survie" "paper.jar" "25565" "$GREEN"
launch_server "Créatif" "servers/creatif" "paper.jar" "25566" "$BLUE"
launch_server "MiniJeux" "servers/minijeux" "paper.jar" "25567" "$YELLOW"

# Attendre 5 secondes pour que les sous-serveurs démarrent
sleep 5

# Lancer Velocity
launch_server "Velocity" "velocity" "velocity.jar" "25577" "$RED"

echo -e "\n${YELLOW}Tous les serveurs ont été lancés!${NC}"
echo -e "Utilisez 'screen -r <nom_du_serveur>' pour accéder à la console d'un serveur."
echo -e "Exemple: screen -r Lobby"
echo -e "Pour quitter un screen sans le fermer: Ctrl+A puis D${NC}"
