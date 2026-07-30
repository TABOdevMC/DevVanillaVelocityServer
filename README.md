# DevVanillaVelocityServer

Un serveur Minecraft **Velocity** avec **3 sous-serveurs Paper** pour la version **1.20.6**.

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
    ├── survie/                # Sous-serveur en mode Survie
    │   ├── server.properties   # Configuration du serveur
    │   ├── paper.yml           # Optimisations Paper
    │   ├── eula.txt            # EULA Minecraft
    │   └── start.sh            # Script de lancement
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
  Placez le fichier `.jar` dans chaque dossier des sous-serveurs (`servers/survie/`, `servers/creatif/`, `servers/minijeux/`) et renommez-les en `paper.jar`.

### 2. Accepter l'EULA

Pour chaque sous-serveur, modifiez le fichier `eula.txt` et changez `eula=false` en `eula=true`.

### 3. Générer la clé de forwarding

Exécutez la commande suivante pour générer une clé secrète pour le forwarding des informations des joueurs :

```bash
java -jar velocity.jar --generate-forwarding-secret
```

Copiez la clé générée et remplacez `votre_cle_secrete_ici` dans le fichier `velocity/forwarding.secret`.

### 4. Configurer le forwarding dans Paper

Pour chaque sous-serveur Paper, ajoutez les lignes suivantes dans le fichier `server.properties` :

```properties
bungeecord: true
online-mode: false
```

> **Note** : Si vous utilisez `online-mode: true` dans Velocity, assurez-vous que `online-mode` est à `false` dans les sous-serveurs Paper pour éviter les conflits.

## Lancement

### 1. Lancer les sous-serveurs Paper

Ouvrez **3 terminaux séparés** et lancez chaque sous-serveur avec la commande suivante :

```bash
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

Ouvrez un **4ème terminal** et lancez Velocity :

```bash
cd velocity
./start.sh velocity.jar
```

## Configuration des serveurs

### Velocity

- **Port** : `25577` (configurable dans `velocity.toml`)
- **MOTD** : `§6DevVanilla §8| §eVelocity Proxy`
- **Servers backend** : `survie`, `creatif`, `minijeux` (configurés dans `servers.json`)

### Sous-serveurs Paper

| Serveur    | Port  | Mode       | Difficulté | PvP  | Vol (Flight) | Type de monde       |
|------------|-------|------------|------------|------|--------------|---------------------|
| **Survie** | 25565 | Survival   | Normal     | Oui  | Non          | Default (Survie)    |
| **Créatif**| 25566 | Creative   | Peaceful   | Non  | Oui          | Flat (Créatif)      |
| **Mini-Jeux**|25567| Adventure  | Normal     | Oui  | Non          | Default (Mini-Jeux) |

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

## Ajouter des plugins

### Plugins Velocity

Placez les plugins `.jar` dans le dossier `velocity/plugins/`.

### Plugins Paper

Placez les plugins `.jar` dans le dossier `plugins/` de chaque sous-serveur.

## Commandes utiles

### Velocity

| Commande | Description |
|----------|-------------|
| `/server survie` | Envoyer un joueur sur le serveur Survie |
| `/server creatif` | Envoyer un joueur sur le serveur Créatif |
| `/server minijeux` | Envoyer un joueur sur le serveur Mini-Jeux |

### Paper

| Commande | Description |
|----------|-------------|
| `/gamemode survival @a` | Passer tous les joueurs en mode Survie |
| `/gamemode creative @a` | Passer tous les joueurs en mode Créatif |
| `/time set day` | Passer à la journée |
| `/weather clear` | Arrêter la pluie |

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

## Liens utiles

- [Velocity](https://papermc.io/downloads#Velocity)
- [Paper](https://papermc.io/downloads)
- [Documentation Velocity](https://papermc.io/velocity/)
- [Documentation Paper](https://papermc.io/paper/)
