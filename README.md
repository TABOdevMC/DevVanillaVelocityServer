# DevVanillaVelocityServer

Un serveur Minecraft **Velocity** avec **4 sous-serveurs Paper** pour la version **1.20.6** :
- **Lobby** (point d'entrée pour les joueurs)
- **Survie** (mode survie classique)
- **Créatif** (mode créatif)
- **Mini-Jeux** (pour les jeux personnalisés)

## 📁 Structure du projet

```
DevVanillaVelocityServer/
├── velocity/                          # Proxy Velocity
│   ├── velocity.toml                  # Configuration principale
│   ├── servers.json                   # Liste des sous-serveurs
│   ├── forwarding.secret              # Clé de forwarding
│   ├── start.sh                       # Lancement (Linux/macOS)
│   ├── start.bat                      # Lancement (Windows)
│   └── plugins/                       # Plugins Velocity
│       ├── luckperms/                 # Gestion des permissions
│       │   └── config.yml
│       ├── tab-list/                  # Tablist personnalisée
│       │   └── config.json
│       ├── advancedban/               # Bans inter-serveurs
│       │   └── config.yml
│       ├── velocityauth/              # Authentification
│       │   └── config.toml
│       └── redisbungee/               # Synchronisation Redis
│           └── config.yml
│
├── servers/                           # Sous-serveurs Paper
│   ├── lobby/                         # Lobby (port 25568)
│   │   ├── server.properties
│   │   ├── paper.yml
│   │   ├── eula.txt
│   │   ├── start.sh
│   │   ├── start.bat
│   │   └── plugins/                   # Plugins du Lobby
│   │       ├── luckperms/
│   │       │   └── config.yml
│   │       └── essentials/
│   │           └── config.yml
│   │
│   ├── survie/                        # Survie (port 25565)
│   │   ├── server.properties
│   │   ├── paper.yml
│   │   ├── eula.txt
│   │   ├── start.sh
│   │   ├── start.bat
│   │   └── plugins/
│   │       └── luckperms/
│   │           └── config.yml
│   │
│   ├── creatif/                       # Créatif (port 25566)
│   │   ├── server.properties
│   │   ├── paper.yml
│   │   ├── eula.txt
│   │   ├── start.sh
│   │   ├── start.bat
│   │   └── plugins/
│   │       └── luckperms/
│   │           └── config.yml
│   │
│   └── minijeux/                      # Mini-Jeux (port 25567)
│       ├── server.properties
│       ├── paper.yml
│       ├── eula.txt
│       ├── start.sh
│       ├── start.bat
│       └── plugins/
│           └── luckperms/
│               └── config.yml
│
├── download_plugins.sh               # Télécharge les plugins (Linux/macOS)
├── download_plugins.bat              # Télécharge les plugins (Windows)
├── start_all.sh                       # Lance tous les serveurs (Linux/macOS)
├── start_all.bat                      # Lance tous les serveurs (Windows)
├── .gitignore                         # Exclut logs, mondes, plugins .jar
└── README.md                          # Ce fichier
```

---

## 📌 Prérequis

- **Java 17+** (recommandé : Java 21)
  - [Télécharger Java (Adoptium)](https://adoptium.net/)
- **Velocity 3.3.0-SNAPSHOT** (compatible Minecraft 1.20.6)
  - [Télécharger Velocity](https://papermc.io/downloads#Velocity)
- **Paper 1.20.6**
  - [Télécharger Paper](https://papermc.io/downloads)

---

## 🚀 Installation

### 1. Télécharger les JARs

- **Velocity** : Placez `velocity.jar` dans `velocity/`.
- **Paper** : Placez `paper.jar` dans chaque dossier `servers/<nom>/`.

### 2. Accepter l'EULA
Modifiez `eula.txt` dans chaque sous-serveur :
```diff
- eula=false
+ eula=true
```

### 3. Générer la clé de forwarding
```bash
# Linux/macOS
java -jar velocity/velocity.jar --generate-forwarding-secret

# Windows
java -jar velocity\velocity.jar --generate-forwarding-secret
```
Copiez la clé dans `velocity/forwarding.secret`.

### 4. Configurer le forwarding dans Paper
Dans `server.properties` de chaque sous-serveur :
```properties
bungeecord: true
online-mode: false
```

---

## 🎮 Lancement

### **Linux/macOS**
```bash
# Lancer tous les serveurs
./start_all.sh

# Ou lancer manuellement
cd servers/lobby && ./start.sh paper.jar
cd servers/survie && ./start.sh paper.jar
# ... etc.
```

### **Windows**
```cmd
:: Lancer tous les serveurs
start_all.bat

:: Ou lancer manuellement
cd servers\lobby && start.bat paper.jar
cd servers\survie && start.bat paper.jar
:: ... etc.
```

---

## 🔌 Plugins globaux

### 📋 **Liste des plugins installés**

| Plugin | Type | Description | Lien |
|--------|------|-------------|------|
| **LuckPerms** | Velocity + Paper | Gestion globale des permissions (rangs, groupes). | [LuckPerms](https://luckperms.net/) |
| **TabList** | Velocity | Tablist personnalisée et globale. | [TabList](https://github.com/Exceptionflug/TabList) |
| **AdvancedBan** | Velocity | Bans inter-serveurs (via MySQL/Redis). | [AdvancedBan](https://github.com/Leako/AdvancedBan) |
| **VelocityAuth** | Velocity | Authentification centralisée (login/register). | [VelocityAuth](https://github.com/Patbox/VelocityAuth) |
| **RedisBungee** | Velocity | Synchronisation des données entre serveurs. | [RedisBungee](https://github.com/ImaginaryDevelopment/RedisBungee) |
| **EssentialsX** | Paper (Lobby) | Commandes de base (`/warp`, `/spawn`, etc.). | [EssentialsX](https://essentialsx.net/) |

---

### 📂 **Structure des plugins**

#### **Velocity** (`velocity/plugins/`)
```
velocity/plugins/
├── luckperms/          # Gestion des permissions
│   ├── config.yml     # Configuration principale
│   └── luckperms.h2   # Base de données (H2)
│
├── tab-list/           # Tablist personnalisée
│   └── config.json
│
├── advancedban/        # Bans inter-serveurs
│   ├── config.yml
│   └── advancedban/    # Base de données
│
├── velocityauth/       # Authentification
│   ├── config.toml
│   └── velocityauth/   # Base de données
│
└── redisbungee/        # Synchronisation Redis
    └── config.yml
```

#### **Lobby** (`servers/lobby/plugins/`)
```
servers/lobby/plugins/
├── luckperms/          # Permissions (synchronisées avec Velocity)
│   └── config.yml
│
└── essentials/         # Commandes de base
    └── config.yml
```

#### **Autres serveurs** (`servers/<nom>/plugins/`)
```
servers/<nom>/plugins/
└── luckperms/          # Permissions (synchronisées avec Velocity)
    └── config.yml
```

---

### 🛠️ **Télécharger les plugins automatiquement**

#### **Linux/macOS**
```bash
chmod +x download_plugins.sh
./download_plugins.sh
```

#### **Windows**
```cmd
download_plugins.bat
```

> ⚠️ **Note** : Les liens de téléchargement dans les scripts pointent vers les dernières versions stables. Si un lien est obsolète, vérifiez les versions sur les sites officiels.

---

### ⚙️ **Configuration des plugins**

#### **1. LuckPerms (Permissions globales)**

- **Fichier** : `velocity/plugins/luckperms/config.yml`
- **Fonction** : Gère les permissions pour tous les serveurs.

**Exemple de configuration** :
```yaml
# Stockage (MySQL recommandé pour la synchronisation)
storage:
  method: h2  # ou mysql pour une base de données centrale
  h2:
    file: "{DIR}/luckperms.h2"

# Synchronisation entre serveurs
sync:
  enabled: true
  interval: 15  # Synchronisation toutes les 15 secondes

# Groupes par défaut
groups:
  default:
    permissions:
      - "minecraft.command.help"
      - "minecraft.command.list"
    default: true
  
  vip:
    permissions:
      - "essentials.fly"
      - "essentials.nick"
    inheritance:
      - default
  
  mod:
    permissions:
      - "minecraft.command.kick"
      - "minecraft.command.ban"
      - "luckperms.editor"
    inheritance:
      - vip
  
  admin:
    permissions:
      - "*"
    inheritance:
      - mod
```

**Commandes utiles** :
| Commande | Description |
|----------|-------------|
| `/lp editor` | Ouvrir l'éditeur de permissions. |
| `/lp group <nom> permission set <permission>` | Ajouter une permission à un groupe. |
| `/lp user <joueur> group add <groupe>` | Ajouter un joueur à un groupe. |

---

#### **2. TabList (Tablist personnalisée)**

- **Fichier** : `velocity/plugins/tab-list/config.json`
- **Fonction** : Affiche une tablist personnalisée avec des informations globales.

**Exemple de configuration** :
```json
{
  "header": [
    "",
    "§6§lDevVanilla §8| §eBienvenue %player% !",
    "§7Joueurs en ligne: §a%online%",
    ""
  ],
  "footer": [
    "",
    "§7Serveur: §b%server%",
    "§7Ping: §a%ping%ms",
    "§7Date: §e%date%",
    ""
  ],
  "tab-format": {
    "default": "§7%prefix%%name% §8| §c%health%❤",
    "vip": "§a%prefix%%name% §8| §c%health%❤",
    "mod": "§2%prefix%%name% §8| §c%health%❤",
    "admin": "§4%prefix%%name% §8| §c%health%❤"
  },
  "use-luckperms": true
}
```

**Placeholders disponibles** :
- `%player%` : Nom du joueur.
- `%online%` : Nombre de joueurs en ligne.
- `%server%` : Nom du serveur actuel.
- `%ping%` : Ping du joueur.
- `%prefix%` : Préfixe du joueur (via LuckPerms).
- `%health%` : Points de vie du joueur.

---

#### **3. AdvancedBan (Bans inter-serveurs)**

- **Fichier** : `velocity/plugins/advancedban/config.yml`
- **Fonction** : Gère les bans, kicks, mutes et warnings de manière globale.

**Exemple de configuration** :
```yaml
# Stockage (MySQL recommandé pour les grands serveurs)
database:
  type: h2  # ou mysql
  h2:
    path: "{DIR}/advancedban"

# Messages
messages:
  ban:
    broadcast: "§c%player% a été banni par %operator% pour : %reason%"
    notify: "§cVous avez été banni !\n§7Raison : %reason%\n§7Expire : %expire%"
  
  tempban:
    broadcast: "§c%player% a été temporairement banni pour : %reason% (%duration%)"
    notify: "§cBanni temporairement !\n§7Raison : %reason%\n§7Durée : %duration%"

# Permissions
permissions:
  ban: "advancedban.ban"
  tempban: "advancedban.tempban"
  unban: "advancedban.unban"
  kick: "advancedban.kick"
  mute: "advancedban.mute"
  warn: "advancedban.warn"
```

**Commandes utiles** :
| Commande | Description |
|----------|-------------|
| `/ban <joueur> <raison>` | Bannir un joueur. |
| `/tempban <joueur> <durée> <raison>` | Bannir temporairement un joueur. |
| `/unban <joueur>` | Débannir un joueur. |
| `/kick <joueur> <raison>` | Éjecter un joueur. |
| `/mute <joueur> <raison>` | Muter un joueur. |
| `/warn <joueur> <raison>` | Avertir un joueur. |
| `/history <joueur>` | Voir l'historique des sanctions d'un joueur. |

**Durées pour `/tempban`** :
- `1s` : 1 seconde
- `1m` : 1 minute
- `1h` : 1 heure
- `1d` : 1 jour
- `1w` : 1 semaine
- `1mo` : 1 mois
- `1y` : 1 an
- `perm` : Permanent

---

#### **4. VelocityAuth (Authentification)**

- **Fichier** : `velocity/plugins/velocityauth/config.toml`
- **Fonction** : Authentification centralisée avant de rejoindre un serveur.

**Exemple de configuration** :
```toml
# Mode de fonctionnement
# - NONE: Pas d'authentification
# - REGISTER: Les joueurs doivent s'inscrire
# - LOGIN: Les joueurs doivent se connecter (inscription désactivée)
# - BOTH: Les joueurs peuvent s'inscrire ou se connecter
mode = "BOTH"

# Serveur de fallback (où les joueurs sont envoyés après l'authentification)
fallback-server = "lobby"

# Messages
messages {
    login {
        success = "§aConnexion réussie ! Bienvenue, %player% !"
        failure = "§cMot de passe incorrect !"
    }
    
    register {
        success = "§aInscription réussie ! Bienvenue, %player% !"
        failure = "§cCe pseudo est déjà enregistré !"
        password-too-short = "§cLe mot de passe doit contenir au moins 4 caractères !"
    }
}

# Stockage
database {
    type = "h2"
    h2 {
        path = "{DIR}/velocityauth"
    }
}

# Sécurité
security {
    hash-algorithm = "BCRYPT"
    min-password-length = 4
    prevent-multiple-logins = true
    max-login-attempts = 5
    tempban-duration = 300  # 5 minutes
}
```

**Commandes utiles** :
| Commande | Description |
|----------|-------------|
| `/login <motdepasse>` | Se connecter. |
| `/register <motdepasse> <confirmation>` | S'inscrire. |
| `/changepassword <ancien> <nouveau>` | Changer son mot de passe. |

---

#### **5. RedisBungee (Synchronisation)**

- **Fichier** : `velocity/plugins/redisbungee/config.yml`
- **Fonction** : Synchronise les données entre Velocity et les serveurs Paper (optionnel mais utile pour AdvancedBan et LuckPerms).

**Exemple de configuration** :
```yaml
redis:
  enabled: false  # Activez si vous utilisez Redis
  host: "127.0.0.1"
  port: 6379
  password: ""  # Mot de passe Redis (laisser vide si aucun)
  database: 0

sync:
  chat: true      # Synchroniser le chat
  commands: true  # Synchroniser les commandes
  permissions: true  # Synchroniser les permissions
  bans: true      # Synchroniser les bans
```

> ⚠️ **Note** : Pour utiliser Redis, vous devez installer un serveur Redis. Vous pouvez le télécharger [ici](https://redis.io/download).

---

#### **6. EssentialsX (Lobby)**

- **Fichier** : `servers/lobby/plugins/essentials/config.yml`
- **Fonction** : Commandes de base pour le Lobby (`/warp`, `/spawn`, etc.).

**Exemple de configuration** :
```yaml
# Coordonnées du spawn
spawn:
  x: 0
  y: 64
  z: 0
  world: "world_lobby"

# Warps vers les autres serveurs
warps:
  survie:
    x: 0
    y: 64
    z: 0
    world: "world_lobby"
    command: "server survie"
  
  creatif:
    x: 0
    y: 64
    z: 0
    world: "world_lobby"
    command: "server creatif"
  
  minijeux:
    x: 0
    y: 64
    z: 0
    world: "world_lobby"
    command: "server minijeux"

# Activer le vol dans le Lobby
fly:
  enabled: true

# Format du chat
chat:
  format: "§7[%prefix%§7] %player%: %message%"
```

**Commandes utiles** :
| Commande | Description |
|----------|-------------|
| `/spawn` | Retourner au spawn. |
| `/warp <nom>` | Se téléporter à un warp. |
| `/setwarp <nom>` | Créer un warp. |
| `/fly` | Activer/désactiver le vol. |
| `/list` | Lister les joueurs en ligne. |

---

### 🔧 **Synchronisation entre serveurs**

Pour que les **bans** et les **permissions** soient globaux, vous avez deux options :

#### **Option 1 : Utiliser MySQL (recommandé)**
1. Installez un serveur MySQL (ex: [XAMPP](https://www.apachefriends.org/), [MariaDB](https://mariadb.org/)).
2. Modifiez les fichiers de configuration de **LuckPerms** et **AdvancedBan** pour utiliser MySQL :
   ```yaml
   # Dans velocity/plugins/luckperms/config.yml
   storage:
     method: mysql
     mysql:
       address: "127.0.0.1:3306"
       database: "luckperms"
       username: "root"
       password: "votre_mot_de_passe"
   ```
   ```yaml
   # Dans velocity/plugins/advancedban/config.yml
   database:
     type: mysql
     mysql:
       host: "127.0.0.1"
       port: 3306
       database: "advancedban"
       username: "root"
       password: "votre_mot_de_passe"
   ```

#### **Option 2 : Utiliser Redis (plus rapide)**
1. Installez un serveur Redis ([Télécharger Redis](https://redis.io/download)).
2. Activez Redis dans **RedisBungee** et **AdvancedBan** :
   ```yaml
   # Dans velocity/plugins/redisbungee/config.yml
   redis:
     enabled: true
     host: "127.0.0.1"
     port: 6379
   ```
   ```yaml
   # Dans velocity/plugins/advancedban/config.yml
   redis:
     enabled: true
     host: "127.0.0.1"
     port: 6379
   ```

---

## 📜 Configuration des serveurs

### **Velocity**
- **Port** : `25577`
- **MOTD** : `§6DevVanilla §8| §eVelocity Proxy`
- **Serveur par défaut** : `lobby`
- **Servers backend** : `lobby`, `survie`, `creatif`, `minijeux`

### **Sous-serveurs Paper**

| Serveur    | Port  | Mode       | Difficulté | PvP  | Vol | Type de monde | Description |
|------------|-------|------------|------------|------|-----|--------------|-------------|
| **Lobby**  | 25568 | Adventure  | Peaceful   | ❌   | ✅  | Flat         | Point d'entrée |
| **Survie** | 25565 | Survival   | Normal     | ✅   | ❌  | Default      | Mode survie |
| **Créatif**| 25566 | Creative   | Peaceful   | ❌   | ✅  | Flat         | Mode créatif |
| **Mini-Jeux**|25567| Adventure  | Normal     | ✅   | ❌  | Default      | Jeux personnalisés |

---

## 🎯 Commandes utiles

### **Velocity**
| Commande | Description |
|----------|-------------|
| `/server lobby` | Envoyer un joueur sur le Lobby. |
| `/server survie` | Envoyer un joueur sur Survie. |
| `/server creatif` | Envoyer un joueur sur Créatif. |
| `/server minijeux` | Envoyer un joueur sur Mini-Jeux. |
| `/list` | Lister les serveurs disponibles. |

### **AdvancedBan (Bans globaux)**
| Commande | Description |
|----------|-------------|
| `/ban <joueur> <raison>` | Bannir un joueur. |
| `/tempban <joueur> <durée> <raison>` | Bannir temporairement. |
| `/unban <joueur>` | Débannir un joueur. |
| `/kick <joueur> <raison>` | Éjecter un joueur. |
| `/mute <joueur> <raison>` | Muter un joueur. |
| `/warn <joueur> <raison>` | Avertir un joueur. |

### **LuckPerms (Permissions)**
| Commande | Description |
|----------|-------------|
| `/lp editor` | Ouvrir l'éditeur de permissions. |
| `/lp group <nom> permission set <permission>` | Ajouter une permission. |
| `/lp user <joueur> group add <groupe>` | Ajouter un joueur à un groupe. |

### **VelocityAuth (Authentification)**
| Commande | Description |
|----------|-------------|
| `/login <motdepasse>` | Se connecter. |
| `/register <motdepasse> <confirmation>` | S'inscrire. |

### **EssentialsX (Lobby)**
| Commande | Description |
|----------|-------------|
| `/spawn` | Retourner au spawn. |
| `/warp <nom>` | Se téléporter à un warp. |
| `/setwarp <nom>` | Créer un warp. |
| `/fly` | Activer/désactiver le vol. |

---

## ⚠️ Résolution des problèmes

### **Problèmes avec les plugins**
| Problème | Solution |
|----------|----------|
| **Plugin non chargé** | Vérifiez que le `.jar` est dans le bon dossier `plugins/`. |
| **Erreur de dépendance** | Téléchargez les dépendances manquantes (ex: Vault pour EssentialsX). |
| **Permissions non synchronisées** | Vérifiez que LuckPerms utilise la même base de données (MySQL/Redis) sur tous les serveurs. |
| **Bans non globaux** | Vérifiez que AdvancedBan utilise MySQL ou Redis. |
| **Authentification ne fonctionne pas** | Vérifiez que `fallback-server` est bien configuré dans VelocityAuth. |

### **Problèmes avec Redis**
| Problème | Solution |
|----------|----------|
| **Connexion refusée** | Vérifiez que Redis est lancé (`redis-server`). |
| **Mot de passe incorrect** | Vérifiez le mot de passe dans `velocity/plugins/redisbungee/config.yml`. |
| **Base de données non trouvée** | Vérifiez que la base de données Redis existe (par défaut : 0). |

### **Problèmes avec MySQL**
| Problème | Solution |
|----------|----------|
| **Connexion refusée** | Vérifiez que MySQL est lancé et que les identifiants sont corrects. |
| **Base de données non trouvée** | Créez la base de données avec `CREATE DATABASE luckperms;` (ou `advancedban`). |
| **Permissions insuffisantes** | Donnez les permissions à l'utilisateur MySQL : `GRANT ALL ON luckperms.* TO 'user'@'localhost';` |

---

## 🔗 Liens utiles

### **Plugins**
- [LuckPerms](https://luckperms.net/) (Permissions)
- [TabList](https://github.com/Exceptionflug/TabList) (Tablist)
- [AdvancedBan](https://github.com/Leako/AdvancedBan) (Bans globaux)
- [VelocityAuth](https://github.com/Patbox/VelocityAuth) (Authentification)
- [RedisBungee](https://github.com/ImaginaryDevelopment/RedisBungee) (Synchronisation)
- [EssentialsX](https://essentialsx.net/) (Commandes de base)

### **Outils**
- [Redis](https://redis.io/download) (Base de données clé-valeur)
- [MySQL](https://dev.mysql.com/downloads/) (Base de données relationnelle)
- [XAMPP](https://www.apachefriends.org/) (Serveur MySQL local)
- [Docker Redis](https://hub.docker.com/_/redis) (Redis en conteneur Docker)

### **Documentation**
- [Documentation Velocity](https://papermc.io/velocity/)
- [Documentation Paper](https://papermc.io/paper/)
- [SpigotMC (Plugins)](https://www.spigotmc.org/resources/)
