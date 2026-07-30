# DevVanillaVelocityServer

Un serveur Minecraft **Velocity** avec **4 sous-serveurs Paper** pour la version **1.20.6** :
- **Lobby** (point d'entrée pour les joueurs)
- **Survie** (mode survie classique)
- **Créatif** (mode créatif)
- **Mini-Jeux** (pour les jeux personnalisés)

## Structure du projet

```
DevVanillaVelocityServer/
├── velocity/                  # Dossier principal de Velocity (Proxy)
│   ├── velocity.toml          # Configuration principale de Velocity
│   ├── servers.json           # Liste des sous-serveurs backend
│   ├── forwarding.secret      # Clé secrète pour le forwarding des infos joueurs
│   ├── start.sh               # Script de lancement pour Velocity
│   ├── plugins/               # Dossier pour les plugins Velocity
│   └── logs/                  # Dossier pour les logs
│
└── servers/                   # Dossier des sous-serveurs Paper
    ├── lobby/                 # Sous-serveur Lobby (point d'entrée)
    │   ├── server.properties   # Configuration du serveur
    │   ├── paper.yml           # Optimisations Paper
    │   ├── eula.txt            # EULA Minecraft
    │   └── start.sh            # Script de lancement
    │
    ├── survie/                # Sous-serveur en mode Survie
    │   ├── server.properties
    │   ├── paper.yml
    │   ├── eula.txt
    │   └── start.sh
    │
    ├── creatif/               # Sous-serveur en mode Créatif
    │   ├── server.properties
    │   ├── paper.yml
    │   ├── eula.txt
    │   └── start.sh
    │
    └── minijeux/              # Sous-serveur pour les Mini-Jeux
        ├── server.properties
        ├── paper.yml
        ├── eula.txt
        └── start.sh

├── start_all.sh               # Lance tous les serveurs en 1 commande
├── .gitignore                 # Exclut logs, mondes, etc.
└── README.md                  # Ce fichier
```

## Prérequis

- **Java 17+** (recommandé : Java 21 pour les meilleures performances)
- **Velocity 3.3.0-SNAPSHOT** (ou version compatible avec Minecraft 1.20.6)
- **Paper 1.20.6** (ou version compatible)

## Installation

### 1. Télécharger les JARs

- **Velocity** : Téléchargez la dernière version depuis [le site officiel](https://papermc.io/downloads#Velocity).
  Placez le fichier `.jar` dans le dossier `velocity/` et renommez-le en `velocity.jar`.

- **Paper** : Téléchargez la dernière version depuis [le site officiel](https://papermc.io/downloads).
  Placez le fichier `.jar` dans chaque dossier des sous-serveurs (`servers/lobby/`, `servers/survie/`, `servers/creatif/`, `servers/minijeux/`) et renommez-les en `paper.jar`.

### 2. Accepter l'EULA

Pour chaque sous-serveur, modifiez le fichier `eula.txt` et changez `eula=false` en `eula=true`.

### 3. Générer la clé de forwarding

Exécutez la commande suivante pour générer une clé secrète pour le forwarding des informations des joueurs :

```bash
java -jar velocity.jar --generate-forwarding-secret
```

Copiez la clé générée et remplacez `votre_cle_secrete_ici` dans le fichier `velocity/forwarding.secret`.

### 4. Configurer le forwarding dans Paper

Pour chaque sous-serveur Paper, assurez-vous que les paramètres suivants sont dans `server.properties` :

```properties
bungeecord: true
online-mode: false
```

> **Note** : Si vous utilisez `online-mode: true` dans Velocity, assurez-vous que `online-mode` est à `false` dans les sous-serveurs Paper pour éviter les conflits.

## Lancement

### 1. Lancer les sous-serveurs Paper

Ouvrez **4 terminaux séparés** et lancez chaque sous-serveur avec la commande suivante :

```bash
# Pour le serveur Lobby
cd servers/lobby
./start.sh paper.jar

# Pour le serveur Survie
cd servers/survie
./start.sh paper.jar

# Pour le serveur Créatif
cd servers/creatif
./start.sh paper.jar

# Pour le serveur Mini-Jeux
cd servers/minijeux
./start.sh paper.jar
```

### 2. Lancer Velocity

Ouvrez un **5ème terminal** et lancez Velocity :

```bash
cd velocity
./start.sh velocity.jar
```

### 3. Utiliser le script de lancement automatique

Vous pouvez aussi lancer tous les serveurs en une seule commande :

```bash
./start_all.sh
```

> *Utilisez `screen -r <nom>` pour accéder à la console d'un serveur (ex: `screen -r Lobby`).*
> *Pour quitter un screen sans le fermer : `Ctrl+A` puis `D`.*

## Configuration des serveurs

### Velocity

- **Port** : `25577` (configurable dans `velocity.toml`)
- **MOTD** : `§6DevVanilla §8| §eVelocity Proxy`
- **Serveur par défaut** : `lobby` (les nouveaux joueurs arrivent ici)
- **Servers backend** : `lobby`, `survie`, `creatif`, `minijeux` (configurés dans `servers.json`)

### Sous-serveurs Paper

| Serveur    | Port  | Mode       | Difficulté | PvP  | Vol (Flight) | Type de monde       | Description                     |
|------------|-------|------------|------------|------|--------------|---------------------|---------------------------------|
| **Lobby**  | 25568 | Adventure  | Peaceful   | ❌   | ✅           | Flat (Lobby)        | Point d'entrée pour les joueurs |
| **Survie** | 25565 | Survival   | Normal     | ✅   | ❌           | Default (Survie)    | Mode survie classique            |
| **Créatif**| 25566 | Creative   | Peaceful   | ❌   | ✅           | Flat (Créatif)      | Mode créatif libre               |
| **Mini-Jeux**|25567| Adventure  | Normal     | ✅   | ❌           | Default (Mini-Jeux) | Pour les jeux personnalisés      |

## Personnalisation

### Changer les ports

- **Velocity** : Modifiez `bind` dans `velocity/velocity.toml`.
- **Sous-serveurs** : Modifiez `server-port` dans `server.properties` de chaque sous-serveur.
  N'oubliez pas de mettre à jour les adresses dans `velocity/servers.json`.

### Changer les modes de jeu

Modifiez `gamemode` dans `server.properties` de chaque sous-serveur :
- `survival` : Mode Survie
- `creative` : Mode Créatif
- `adventure` : Mode Aventure
- `spectator` : Mode Spectateur

### Changer les types de monde

Modifiez `level-type` dans `server.properties` :
- `default` : Monde normal
- `flat` : Monde plat
- `large_biomes` : Biomes larges
- `amplified` : Monde amplifié

### Configurer le serveur par défaut

Dans `velocity/velocity.toml`, modifiez la ligne :
```toml
default_server = "lobby"
```

### Configurer les serveurs de fallback

Dans `velocity/servers.json`, vous pouvez ajouter un tableau `try` pour rediriger les joueurs si le serveur principal est indisponible :
```json
"lobby": {
    "address": "127.0.0.1:25568",
    "motd": "§6§lLobby §8| §eBienvenue sur DevVanilla!",
    "restricted": false,
    "maintenance": false,
    "try": ["survie", "creatif"]
}
```

## Ajouter des plugins

### Plugins Velocity

Placez les plugins `.jar` dans le dossier `velocity/plugins/`.

#### Plugins recommandés pour Velocity :
- **[LuckPerms](https://luckperms.net/)** : Gestion des permissions.
- **[VelocityAuth](https://github.com/Patbox/VelocityAuth)** : Authentification avant de rejoindre un serveur.
- **[ServerSwitcher](https://github.com/Patbox/ServerSwitcher)** : Permet aux joueurs de changer de serveur via des commandes.

### Plugins Paper

Placez les plugins `.jar` dans le dossier `plugins/` de chaque sous-serveur.

#### Plugins recommandés pour le Lobby :
- **[EssentialsX](https://essentialsx.net/)** : Commandes de base (`/warp`, `/spawn`, etc.).
- **[Multiverse-Core](https://www.spigotmc.org/resources/multiverse-core.390/)** : Gestion des mondes et téléportations.
- **[TabList](https://www.spigotmc.org/resources/tab-list.57810/)** : Personnalisation de la tablist.

#### Plugins recommandés pour Survie :
- **[WorldEdit](https://dev.bukkit.org/projects/worldedit)** : Édition de monde.
- **[WorldGuard](https://dev.bukkit.org/projects/worldguard)** : Protection des zones.
- **[Dynmap](https://www.spigotmc.org/resources/dynmap.274/)** : Carte interactive.

#### Plugins recommandés pour Créatif :
- **[WorldEdit](https://dev.bukkit.org/projects/worldedit)** : Édition de monde.
- **[WorldGuard](https://dev.bukkit.org/projects/worldguard)** : Protection des zones.
- **[PlotSquared](https://www.spigotmc.org/resources/plotsquared.1177/)** : Gestion des parcelles.

## Commandes utiles

### Velocity

| Commande | Description |
|----------|-------------|
| `/server lobby` | Envoyer un joueur sur le serveur Lobby |
| `/server survie` | Envoyer un joueur sur le serveur Survie |
| `/server creatif` | Envoyer un joueur sur le serveur Créatif |
| `/server minijeux` | Envoyer un joueur sur le serveur Mini-Jeux |
| `/list` | Lister les serveurs disponibles |

### Paper (Lobby)

| Commande | Description |
|----------|-------------|
| `/spawn` | Retourner au spawn |
| `/warp <nom>` | Se téléporter à un warp |
| `/setwarp <nom>` | Créer un warp |

### Paper (Survie/Créatif/Mini-Jeux)

| Commande | Description |
|----------|-------------|
| `/gamemode survival @a` | Passer tous les joueurs en mode Survie |
| `/gamemode creative @a` | Passer tous les joueurs en mode Créatif |
| `/time set day` | Passer à la journée |
| `/weather clear` | Arrêter la pluie |

## Exemple de configuration pour un plugin de téléportation

Si vous utilisez **Multiverse-Core** ou **EssentialsX** dans le lobby, vous pouvez configurer des commandes pour envoyer les joueurs vers les autres serveurs :

### Avec EssentialsX :
```yaml
# Dans config.yml d'EssentialsX
warps:
  survie:
    x: 0
    y: 64
    z: 0
    world: world_lobby
    command: "server survie"
  creatif:
    x: 0
    y: 64
    z: 0
    world: world_lobby
    command: "server creatif"
  minijeux:
    x: 0
    y: 64
    z: 0
    world: world_lobby
    command: "server minijeux"
```

### Avec un plugin de panneau (ex: **ServerSelector**) :
Vous pouvez créer un menu interactif dans le lobby pour permettre aux joueurs de choisir leur serveur.

## Résolution des problèmes

### Erreur : "Cannot connect to server"

- Vérifiez que les ports des sous-serveurs sont ouverts.
- Vérifiez que les adresses dans `velocity/servers.json` sont correctes.
- Assurez-vous que les sous-serveurs sont lancés **avant** Velocity.

### Erreur : "Invalid session"

- Vérifiez que `online-mode` est à `true` dans `velocity.toml`.
- Vérifiez que `online-mode` est à `false` dans les sous-serveurs Paper.
- Assurez-vous que la clé de forwarding est correcte dans `velocity/forwarding.secret`.

### Erreur : "EULA not accepted"

- Modifiez `eula.txt` dans chaque sous-serveur et changez `eula=false` en `eula=true`.

### Les joueurs ne sont pas redirigés vers le lobby

- Vérifiez que `default_server = "lobby"` est bien présent dans `velocity/velocity.toml`.
- Vérifiez que le serveur `lobby` est bien configuré dans `velocity/servers.json`.

## Liens utiles

- [Velocity](https://papermc.io/downloads#Velocity)
- [Paper](https://papermc.io/downloads)
- [Documentation Velocity](https://papermc.io/velocity/)
- [Documentation Paper](https://papermc.io/paper/)
- [SpigotMC (Plugins)](https://www.spigotmc.org/resources/)
- [EssentialsX](https://essentialsx.net/)
- [LuckPerms](https://luckperms.net/)
