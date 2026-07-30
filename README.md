# DevVanillaVelocityServer

Un serveur Minecraft **Velocity** avec **4 sous-serveurs Paper** pour la version **1.20.6** prenant en charge **Java et Bedrock** en **mode CRACK** :
- **Lobby** (point d'entrée pour les joueurs)
- **Survie** (mode survie classique)
- **Créatif** (mode créatif)
- **Mini-Jeux** (pour les jeux personnalisés)

**Fonctionnalités clés** :
✅ **Serveur CRACK** (offline mode) – Pas besoin de compte premium pour Java
✅ **Support Java + Bedrock** (via Floodgate **et** GeyserMC)
✅ **Authentification unifiée** (`/login` pour tous les joueurs)
✅ **Permissions globales** (LuckPerms)
✅ **Bans inter-serveurs** (AdvancedBan)
✅ **Tablist personnalisée** (TabList)
✅ **Chat global** (via RedisBungee)

---

## 📁 Structure du projet

```
DevVanillaVelocityServer/
├── velocity/                          # Proxy Velocity (mode CRACK)
│   ├── velocity.toml                  # Configuration principale (online_mode = false)
│   ├── servers.json                   # Liste des sous-serveurs
│   ├── forwarding.secret              # Clé de forwarding (optionnelle)
│   ├── start.sh                       # Lancement (Linux/macOS)
│   ├── start.bat                      # Lancement (Windows)
│   └── plugins/                       # Plugins Velocity
│       ├── luckperms/                 # ✅ Gestion des permissions
│       │   └── config.yml
│       ├── tab-list/                  # ✅ Tablist personnalisée
│       │   └── config.json
│       ├── advancedban/               # ✅ Bans inter-serveurs
│       │   └── config.yml
│       ├── velocityauth/              # ✅ Authentification unifiée (/login)
│       │   └── config.toml
│       ├── redisbungee/               # ✅ Synchronisation Redis
│       │   └── config.yml
│       ├── floodgate/                  # ✅ Support Bedrock (mode OFFLINE)
│       │   └── config.yml
│       └── geyser/                     # ✅ Alternative à Floodgate (Bedrock)
│           └── config.yml
│
├── servers/                           # Sous-serveurs Paper
│   ├── lobby/                         # Lobby (port 25568)
│   │   ├── server.properties          # online-mode = false
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
│   │   ├── server.properties          # online-mode = false
│   │   ├── paper.yml
│   │   ├── eula.txt
│   │   ├── start.sh
│   │   ├── start.bat
│   │   └── plugins/
│   │       └── luckperms/
│   │           └── config.yml
│   │
│   ├── creatif/                       # Créatif (port 25566)
│   │   ├── server.properties          # online-mode = false
│   │   ├── paper.yml
│   │   ├── eula.txt
│   │   ├── start.sh
│   │   ├── start.bat
│   │   └── plugins/
│   │       └── luckperms/
│   │           └── config.yml
│   │
│   └── minijeux/                      # Mini-Jeux (port 25567)
│       ├── server.properties          # online-mode = false
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
- **Ports ouverts** :
  - `25577` (Velocity - Java)
  - `19132` (Velocity - Bedrock via Floodgate/GeyserMC)
  - `25565` (Survie)
  - `25566` (Créatif)
  - `25567` (Mini-Jeux)
  - `25568` (Lobby)

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

### 3. Configurer le mode CRACK
Pour un **serveur CRACK**, assurez-vous que `online_mode` est à **`false`** dans :
- `velocity/velocity.toml`
- `servers/<nom>/server.properties` (pour chaque sous-serveur)

**Exemple pour `velocity/velocity.toml`** :
```toml
online_mode = false  # Mode CRACK
```

**Exemple pour `servers/survie/server.properties`** :
```properties
online-mode=false  # Mode CRACK
bungeecord=true
```

---

## 🎮 Support Java + Bedrock (Mode CRACK)

### **Floodgate + GeyserMC**
Ces deux plugins permettent aux joueurs **Bedrock** de rejoindre votre serveur **Java** en mode CRACK.

| Plugin | Rôle | Port | Mode CRACK |
|--------|------|------|------------|
| **Floodgate** | Conversion des connexions Bedrock → Java | `19132` | ✅ Oui |
| **GeyserMC** | Proxy Bedrock → Java (alternative) | `19132` | ✅ Oui |

> ⚠️ **Note** : Vous pouvez utiliser **Floodgate seul** ou **Floodgate + GeyserMC** pour une meilleure compatibilité.

---

### **Configuration de Floodgate**
- **Fichier** : `velocity/plugins/floodgate/config.yml`
- **Mode** : `OFFLINE` (pour un serveur CRACK)

**Exemple de configuration** :
```yaml
# velocity/plugins/floodgate/config.yml
enabled: true
mode: OFFLINE  # Mode CRACK (les joueurs Bedrock peuvent utiliser n'importe quel pseudo)
bedrock-port: 19132
bedrock-bind: "0.0.0.0"
welcome-message: "§aBienvenue, %player% ! Vous jouez depuis Bedrock."
bedrock-prefix: "§7[BE] "
sync-chat: true

# Compatibilité avec GeyserMC
geyser:
  enabled: true
  use-geyser: true
```

---

### **Configuration de GeyserMC**
- **Fichier** : `velocity/plugins/geyser/config.yml`
- **Mode** : `FLOODGATE` (pour fonctionner avec Floodgate)

**Exemple de configuration** :
```yaml
# velocity/plugins/geyser/config.yml
enabled: true
mode: FLOODGATE  # Fonctionne avec Floodgate
bind-address: "0.0.0.0"
port: 19132

motd:
  line1: "§6DevVanilla §8| §eRejoignez depuis Bedrock !"
  line2: "§7Serveur CRACK (Java + Bedrock)"

player:
  prefix: "§7[BE] "
  
chat:
  sync: true
  bedrock-format: "§7%prefix%%name%§7: %message%"
  java-format: "§7%prefix%%name%§7: %message%"

security:
  prevent-spoofing: true
```

---

## 🔐 Authentification unifiée (`/login`)

### **VelocityAuth (Mode CRACK)**
VelocityAuth permet une **authentification centralisée** pour les joueurs **Java et Bedrock** avant de rejoindre un serveur.

#### **Configuration pour le mode CRACK**
- **Fichier** : `velocity/plugins/velocityauth/config.toml`
- **Mode** : `BOTH` (les joueurs peuvent s’inscrire ou se connecter)

**Exemple de configuration** :
```toml
# velocity/plugins/velocityauth/config.toml
enabled = true
mode = "BOTH"  # NONE, REGISTER, LOGIN ou BOTH
fallback-server = "lobby"

# Options pour les joueurs Java (CRACK)
java {
    enabled = true
    mode = "BOTH"  # Les joueurs Java doivent s'inscrire ou se connecter
    login-message = "§cVeuillez vous connecter avec /login <motdepasse>"
    register-message = "§cVeuillez vous inscrire avec /register <motdepasse> <confirmation>"
}

# Options pour les joueurs Bedrock
bedrock {
    enabled = true
    mode = "BOTH"  # Les joueurs Bedrock doivent s'inscrire ou se connecter
    login-message = "§cVeuillez vous connecter avec /login <motdepasse>"
    register-message = "§cVeuillez vous inscrire avec /register <motdepasse> <confirmation>"
}

# Sécurité pour le mode CRACK
security {
    hash-algorithm = "BCRYPT"
    min-password-length = 4
    prevent-multiple-logins = true
    max-login-attempts = 5
    tempban-duration = 300  # 5 minutes
    
    # Options spécifiques pour le mode CRACK
    crack {
        prevent-name-conflict = true
        allow-special-characters = false
        allow-premium-names = true
    }
}
```

#### **Commandes pour les joueurs**
| Commande | Description | Exemple |
|----------|-------------|---------|
| `/login <motdepasse>` | Se connecter | `/login monmotdepasse` |
| `/register <motdepasse> <confirmation>` | S’inscrire | `/register monmotdepasse monmotdepasse` |
| `/changepassword <ancien> <nouveau>` | Changer son mot de passe | `/changepassword ancien nouveau` |

> ✅ **Tous les joueurs (Java et Bedrock) doivent utiliser ces commandes !**

---

## 📜 Plugins globaux

### **Liste des plugins installés**

| Plugin | Type | Description | Lien |
|--------|------|-------------|------|
| **LuckPerms** | Velocity + Paper | Gestion globale des permissions (rangs, groupes). | [LuckPerms](https://luckperms.net/) |
| **TabList** | Velocity | Tablist personnalisée et globale. | [TabList](https://github.com/Exceptionflug/TabList) |
| **AdvancedBan** | Velocity | Bans inter-serveurs (ban, tempban, kick, mute). | [AdvancedBan](https://github.com/Leako/AdvancedBan) |
| **VelocityAuth** | Velocity | Authentification centralisée (`/login`). | [VelocityAuth](https://github.com/Patbox/VelocityAuth) |
| **RedisBungee** | Velocity | Synchronisation des données (chat, bans, permissions). | [RedisBungee](https://github.com/ImaginaryDevelopment/RedisBungee) |
| **Floodgate** | Velocity | Support des joueurs Bedrock (mode OFFLINE). | [Floodgate](https://github.com/GeyserMC/Floodgate) |
| **GeyserMC** | Velocity | Proxy Bedrock → Java (alternative). | [GeyserMC](https://geysermc.org/) |
| **EssentialsX** | Paper (Lobby) | Commandes de base (`/warp`, `/spawn`, `/fly`). | [EssentialsX](https://essentialsx.net/) |

---

### **Structure des plugins**

#### **Velocity** (`velocity/plugins/`)
```
velocity/plugins/
├── luckperms/          # ✅ Gestion des permissions
│   └── config.yml     # Groupes : default, vip, mod, admin
│
├── tab-list/           # ✅ Tablist personnalisée
│   └── config.json     # Header/Footer avec placeholders
│
├── advancedban/        # ✅ Bans inter-serveurs
│   └── config.yml      # Messages, permissions, stockages
│
├── velocityauth/       # ✅ Authentification unifiée (/login)
│   └── config.toml     # Mode BOTH pour Java et Bedrock
│
├── redisbungee/        # ✅ Synchronisation Redis
│   └── config.yml      # Chat global, sync bans/permissions
│
├── floodgate/          # ✅ Support Bedrock (mode OFFLINE)
│   └── config.yml      # Port 19132, mode OFFLINE
│
└── geyser/             # ✅ Alternative à Floodgate (Bedrock)
    └── config.yml      # Port 19132, mode FLOODGATE
```

---

### **Télécharger les plugins automatiquement**

#### **Linux/macOS**
```bash
chmod +x download_plugins.sh
./download_plugins.sh
```

#### **Windows**
```cmd
download_plugins.bat
```

> ⚠️ **Note** : Les liens dans les scripts pointent vers les dernières versions stables. Si un lien est obsolète, vérifiez les versions sur les sites officiels.

---

## 🔧 Configuration des plugins

### **1. LuckPerms (Permissions globales)**

- **Fichier** : `velocity/plugins/luckperms/config.yml`
- **Fonction** : Gère les permissions pour tous les serveurs (Java + Bedrock).

**Exemple de configuration** :
```yaml
storage:
  method: h2  # ou mysql pour une base de données centrale
  h2:
    file: "{DIR}/luckperms.h2"

sync:
  enabled: true
  interval: 15

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
      - "advancedban.ban"
      - "advancedban.tempban"
    inheritance:
      - vip
  
  admin:
    permissions:
      - "*"
    inheritance:
      - mod
```

**Commandes utiles** :
```bash
/lp editor                          # Ouvrir l'éditeur de permissions
/lp group vip permission set essentials.fly  # Donner /fly aux VIP
/lp user Steve group add vip        # Mettre Steve en VIP
```

---

### **2. TabList (Tablist personnalisée)**

- **Fichier** : `velocity/plugins/tab-list/config.json`
- **Fonction** : Affiche une tablist personnalisée avec des informations globales (y compris les joueurs Bedrock).

**Exemple de configuration** :
```json
{
  "header": [
    "",
    "§6§lDevVanilla §8| §eBienvenue %player% !",
    "§7Joueurs: §a%online% §8(§a%java_players% Java§7, §b%bedrock_players% Bedrock§8)",
    "§7Serveur: §b%server%",
    ""
  ],
  "footer": [
    "",
    "§7Ping: §a%ping%ms",
    "§7Date: §e%date%",
    "§7Heure: §e%time%",
    "",
    "§eRejoignez notre Discord: §bdiscord.gg/exemple"
  ],
  "tab-format": {
    "default": "§7%prefix%%name% §8| §c%health%❤",
    "vip": "§a%prefix%%name% §8| §c%health%❤",
    "mod": "§2%prefix%%name% §8| §c%health%❤",
    "admin": "§4%prefix%%name% §8| §c%health%❤",
    "bedrock": "§7%prefix%§7[BE]%name% §8| §c%health%❤"
  },
  "bedrock": {
    "enabled": true,
    "prefix": "§7[BE] ",
    "show-in-tab": true
  }
}
```

**Placeholders disponibles** :
- `%player%` : Nom du joueur
- `%online%` : Nombre total de joueurs en ligne
- `%java_players%` : Nombre de joueurs Java
- `%bedrock_players%` : Nombre de joueurs Bedrock
- `%server%` : Nom du serveur actuel
- `%ping%` : Ping du joueur
- `%prefix%` : Préfixe du joueur (via LuckPerms)
- `%health%` : Points de vie du joueur

---

### **3. AdvancedBan (Bans inter-serveurs)**

- **Fichier** : `velocity/plugins/advancedban/config.yml`
- **Fonction** : Gère les bans, kicks, mutes et warnings de manière globale (Java + Bedrock).

**Exemple de configuration** :
```yaml
database:
  type: h2  # ou mysql pour les grands serveurs
  h2:
    path: "{DIR}/advancedban"

messages:
  ban:
    broadcast: "§c%player% a été banni par %operator% pour : %reason%"
    notify: "§cVous avez été banni !\n§7Raison : %reason%\n§7Expire : %expire%"
  
  tempban:
    broadcast: "§c%player% a été temporairement banni pour : %reason% (%duration%)"
    notify: "§cBanni temporairement !\n§7Raison : %reason%\n§7Durée : %duration%"

permissions:
  ban: "advancedban.ban"
  tempban: "advancedban.tempban"
  unban: "advancedban.unban"
  kick: "advancedban.kick"
  mute: "advancedban.mute"
  warn: "advancedban.warn"
```

**Commandes utiles** :
```bash
/ban <joueur> <raison>                     # Ban permanent
/tempban <joueur> <durée> <raison>        # Ban temporaire (ex: 1d, 1h, 30m)
/unban <joueur>                          # Débannir un joueur
/kick <joueur> <raison>                   # Éjecter un joueur
/mute <joueur> <raison>                   # Muter un joueur
/warn <joueur> <raison>                   # Avertir un joueur
/history <joueur>                        # Voir l'historique des sanctions
```

---

### **4. RedisBungee (Synchronisation)**

- **Fichier** : `velocity/plugins/redisbungee/config.yml`
- **Fonction** : Synchronise le chat, les bans et les permissions entre les serveurs (optionnel mais recommandé).

**Exemple de configuration** :
```yaml
redis:
  enabled: true
  host: "127.0.0.1"
  port: 6379
  password: ""
  database: 0

sync:
  chat: true          # Synchroniser le chat
  commands: true      # Synchroniser les commandes
  permissions: true   # Synchroniser les permissions
  bans: true          # Synchroniser les bans

chat:
  global: true        # Activer le chat global
  format: "§7[%server%] %prefix%%player%§7: %message%"
  
  server-prefixes:
    lobby: "§6[Lobby]"
    survie: "§a[Survie]"
    creatif: "§b[Créatif]"
    minijeux: "§c[Mini-Jeux]"
  
  player-prefixes:
    java: "§7[JAVA]"
    bedrock: "§7[BE]"
```

> ⚠️ **Note** : Pour utiliser Redis, installez un serveur Redis ([Télécharger](https://redis.io/download)).

---

### **5. EssentialsX (Lobby)**

- **Fichier** : `servers/lobby/plugins/essentials/config.yml`
- **Fonction** : Commandes de base pour le Lobby (`/warp`, `/spawn`, `/fly`).

**Exemple de configuration** :
```yaml
spawn:
  x: 0
  y: 64
  z: 0
  world: "world_lobby"

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

fly:
  enabled: true

chat:
  format: "§7[%prefix%§7] %player%: %message%"
```

**Commandes utiles** :
```bash
/spawn              # Retourner au spawn
/warp <nom>         # Se téléporter à un warp
/setwarp <nom>      # Créer un warp
/fly                # Activer/désactiver le vol
/list               # Lister les joueurs en ligne
```

---

## 🔄 Synchronisation entre serveurs

Pour que les **bans**, les **permissions** et le **chat** soient **globaux**, utilisez l’une de ces options :

### **Option 1 : MySQL (recommandé)**
1. Installez un serveur MySQL (ex: [XAMPP](https://www.apachefriends.org/), [MariaDB](https://mariadb.org/)).
2. Modifiez les fichiers de configuration :
   ```yaml
   # velocity/plugins/luckperms/config.yml
   storage:
     method: mysql
     mysql:
       address: "127.0.0.1:3306"
       database: "luckperms"
       username: "root"
       password: "votre_mot_de_passe"
   ```
   ```yaml
   # velocity/plugins/advancedban/config.yml
   database:
     type: mysql
     mysql:
       host: "127.0.0.1"
       port: 3306
       database: "advancedban"
       username: "root"
       password: "votre_mot_de_passe"
   ```

### **Option 2 : Redis (plus rapide)**
1. Installez Redis ([Télécharger](https://redis.io/download)).
2. Activez Redis dans les plugins :
   ```yaml
   # velocity/plugins/redisbungee/config.yml
   redis:
     enabled: true
     host: "127.0.0.1"
     port: 6379
   ```
   ```yaml
   # velocity/plugins/advancedban/config.yml
   redis:
     enabled: true
     host: "127.0.0.1"
     port: 6379
   ```

---

## 📜 Configuration des serveurs

### **Velocity**
- **Port Java** : `25577`
- **Port Bedrock** : `19132` (via Floodgate/GeyserMC)
- **Mode** : `OFFLINE` (serveur CRACK)
- **MOTD** : `§6DevVanilla §8| §eServeur CRACK (Java + Bedrock)`
- **Serveur par défaut** : `lobby`
- **Servers backend** : `lobby`, `survie`, `creatif`, `minijeux`

### **Sous-serveurs Paper**

| Serveur | Port | Mode | Difficulté | PvP | Vol | Type de monde | Description |
|---------|------|------|------------|-----|-----|--------------|-------------|
| **Lobby** | 25568 | Adventure | Peaceful | ❌ | ✅ | Flat | Point d’entrée |
| **Survie** | 25565 | Survival | Normal | ✅ | ❌ | Default | Mode survie |
| **Créatif** | 25566 | Creative | Peaceful | ❌ | ✅ | Flat | Mode créatif |
| **Mini-Jeux** | 25567 | Adventure | Normal | ✅ | ❌ | Default | Jeux personnalisés |

> ⚠️ **Important** : Tous les sous-serveurs doivent avoir `online-mode=false` dans `server.properties`.

---

## 🎯 Commandes utiles

### **Velocity (Admin)**
| Commande | Description |
|----------|-------------|
| `/server lobby` | Envoyer un joueur sur le Lobby. |
| `/server survie` | Envoyer un joueur sur Survie. |
| `/server creatif` | Envoyer un joueur sur Créatif. |
| `/server minijeux` | Envoyer un joueur sur Mini-Jeux. |
| `/list` | Lister les serveurs disponibles. |

---

### **Authentification (`/login`)**
| Commande | Description | Exemple |
|----------|-------------|---------|
| `/login <motdepasse>` | Se connecter | `/login monmotdepasse` |
| `/register <motdepasse> <confirmation>` | S’inscrire | `/register monmotdepasse monmotdepasse` |
| `/changepassword <ancien> <nouveau>` | Changer son mot de passe | `/changepassword ancien nouveau` |

> ✅ **Tous les joueurs (Java et Bedrock) doivent utiliser ces commandes !**

---

### **AdvancedBan (Bans globaux)**
| Commande | Description | Exemple |
|----------|-------------|---------|
| `/ban <joueur> <raison>` | Bannir un joueur | `/ban NotCH Triche` |
| `/tempban <joueur> <durée> <raison>` | Ban temporaire | `/tempban NotCH 1d Triche` |
| `/unban <joueur>` | Débannir un joueur | `/unban NotCH` |
| `/kick <joueur> <raison>` | Éjecter un joueur | `/kick NotCH Flood` |
| `/mute <joueur> <raison>` | Muter un joueur | `/mute NotCH Insultes` |
| `/warn <joueur> <raison>` | Avertir un joueur | `/warn NotCH Avertissement` |

---

### **LuckPerms (Permissions)**
| Commande | Description | Exemple |
|----------|-------------|---------|
| `/lp editor` | Ouvrir l'éditeur de permissions | `/lp editor` |
| `/lp group <nom> permission set <permission>` | Ajouter une permission | `/lp group vip permission set essentials.fly` |
| `/lp user <joueur> group add <groupe>` | Ajouter un joueur à un groupe | `/lp user Steve group add vip` |

---

### **EssentialsX (Lobby)**
| Commande | Description | Exemple |
|----------|-------------|---------|
| `/spawn` | Retourner au spawn | `/spawn` |
| `/warp <nom>` | Se téléporter à un warp | `/warp survie` |
| `/setwarp <nom>` | Créer un warp | `/setwarp survie` |
| `/fly` | Activer/désactiver le vol | `/fly` |

---

## 🖥️ Lancement

### **Linux/macOS**
```bash
# Télécharger les plugins
chmod +x download_plugins.sh
./download_plugins.sh

# Lancer tous les serveurs
./start_all.sh
```

### **Windows**
```cmd
:: Télécharger les plugins
download_plugins.bat

:: Lancer tous les serveurs
start_all.bat
```

---

## ⚠️ Résolution des problèmes

### **Problèmes avec le mode CRACK**
| Problème | Solution |
|----------|----------|
| **Les joueurs Java ne peuvent pas se connecter** | Vérifiez que `online_mode = false` dans `velocity.toml` et `server.properties`. |
| **Les joueurs voient "Invalid session"** | Assurez-vous que `online_mode` est bien à `false` partout. |
| **Les joueurs ne peuvent pas utiliser `/login`** | Vérifiez que VelocityAuth est bien configuré (`mode = "BOTH"`). |

### **Problèmes avec Floodgate/GeyserMC (Bedrock)**
| Problème | Solution |
|----------|----------|
| **Les joueurs Bedrock ne peuvent pas se connecter** | Vérifiez que le port `19132` est ouvert et que Floodgate/GeyserMC est dans `velocity/plugins/`. |
| **Erreur "Connection refused"** | Assurez-vous que Velocity est lancé et que le port `19132` est bien configuré. |
| **Les joueurs Bedrock voient un message d’erreur** | Vérifiez que Floodgate est en mode `OFFLINE` pour un serveur CRACK. |
| **Les joueurs Bedrock ne peuvent pas utiliser `/login`** | Vérifiez que `bedrock.enabled = true` est activé dans `velocityauth/config.toml`. |

### **Problèmes avec VelocityAuth**
| Problème | Solution |
|----------|----------|
| **Les joueurs ne sont pas redirigés après `/login`** | Vérifiez que `fallback-server = "lobby"` est bien configuré. |
| **Les joueurs Bedrock ne peuvent pas se connecter** | Vérifiez que `bedrock.mode = "BOTH"` ou `"LOGIN"` est activé. |
| **Mot de passe oublié** | Utilisez `/changepassword <ancien> <nouveau>`. |

### **Problèmes avec AdvancedBan**
| Problème | Solution |
|----------|----------|
| **Les bans ne sont pas globaux** | Utilisez MySQL ou Redis pour la synchronisation. |
| **Les modérateurs ne voient pas les bans** | Vérifiez les permissions (`advancedban.ban`, `advancedban.tempban`). |

---
n---

## u26a1 Anti-Cheat

Ce projet inclut **deux anti-cheats** pour une protection maximale :

| Anti-Cheat | Type | Description |
|------------|------|-------------|
| **NoCheatPlus** | Paper | Anti-cheat open-source pour les serveurs (fly, speed, kill aura, etc.) |
| **Vulcan** | Velocity | Anti-cheat moderne pour le proxy (paquets illégaux, connexions rapides, etc.) |

> **u2705 Conseil** : Utilisez **les deux** pour une protection optimale ! Voir [ANTI_CHEAT.md](ANTI_CHEAT.md) pour la configuration détaillée.

n---

## 🛡️ Anti-Cheat

### **NoCheatPlus (Paper)**
NoCheatPlus est un **anti-cheat open-source** pour les serveurs Paper. Il détecte les triches comme le fly, le speed, le kill aura, etc.

#### **Configuration**
- **Fichiers** : 
  - `servers/lobby/plugins/nocheatplus/config.yml`
  - `servers/survie/plugins/nocheatplus/config.yml`
  - `servers/creatif/plugins/nocheatplus/config.yml`
  - `servers/minijeux/plugins/nocheatplus/config.yml`

**Exemple de configuration (Survie - stricte)** :
```yaml
detection:
  movement:
    fly:
      enabled: true
      max-violations: 3
      ban-duration: 3600  # Ban de 1 heure
      message: "§cFly détecté !"
    speed:
      enabled: true
      max-violations: 3
      message: "§cSpeed détecté !"
  combat:
    kill-aura:
      enabled: true
      max-cps: 15
      max-violations: 3
      message: "§cKill Aura détecté !"
    reach:
      enabled: true
      max-reach: 3.2
      max-violations: 3
      message: "§cReach trop long !"

punishments:
  default-type: BAN
  default-ban-duration: 3600
```

**Commandes utiles** :
```bash
/ncp reload              # Recharger la configuration
/ncp check <joueur>     # Vérifier un joueur
/ncp bypass <joueur>    # Ajouter un joueur à la liste de bypass
```

---

### **Vulcan (Velocity)**
Vulcan est un **anti-cheat moderne** qui fonctionne au niveau du proxy (Velocity).

#### **Configuration**
- **Fichier** : `velocity/plugins/vulcan/config.yml`

**Exemple de configuration** :
```yaml
detection:
  movement:
    fly:
      enabled: true
      sensitivity: 7  # 1-10 (10 = très sensible)
      max-violations: 5
      punishment: KICK
      message: "§cFly détecté par Vulcan !"
    speed:
      enabled: true
      sensitivity: 7
      max-violations: 5
      message: "§cSpeed détecté par Vulcan !"
  combat:
    kill-aura:
      enabled: true
      sensitivity: 7
      max-cps: 20
      max-violations: 5
      message: "§cKill Aura détecté par Vulcan !"

punishments:
  default-type: KICK
  default-ban-duration: 3600

notifications:
  notify-on-violation: true
  notify-permission: "vulcan.notify"

bypass:
  allow-bypass: true
  bypass-permission: "vulcan.bypass"
```

**Commandes utiles** :
```bash
/vulcan reload          # Recharger la configuration
/vulcan check <joueur>  # Vérifier un joueur
```

---

### **Comparaison NoCheatPlus vs Vulcan**

| Fonctionnalité | NoCheatPlus | Vulcan |
|---------------|-------------|--------|
| **Niveau** | Paper (serveur) | Velocity (proxy) |
| **Détection du fly** | ✅ Oui | ✅ Oui |
| **Détection du speed** | ✅ Oui | ✅ Oui |
| **Détection du kill aura** | ✅ Oui | ✅ Oui |
| **Détection des paquets illégaux** | ❌ Non | ✅ Oui |
| **Détection des connexions rapides** | ❌ Non | ✅ Oui |
| **Configuration par serveur** | ✅ Oui | ❌ Non (global) |
| **Recommandé pour** | Survie, Créatif, Mini-Jeux | Velocity (tous les serveurs) |

> **Conseil** : Utilisez **les deux** pour une protection maximale !

---

## 📦 Liste complète des plugins

| Plugin | Type | Description | Anti-Cheat |
|--------|------|-------------|------------|
| **LuckPerms** | Velocity + Paper | Gestion globale des permissions | ❌ Non |
| **TabList** | Velocity | Tablist personnalisée | ❌ Non |
| **AdvancedBan** | Velocity | Bans inter-serveurs | ❌ Non |
| **VelocityAuth** | Velocity | Authentification unifiée (`/login`) | ❌ Non |
| **RedisBungee** | Velocity | Synchronisation des données | ❌ Non |
| **Floodgate** | Velocity | Support Bedrock (mode OFFLINE) | ❌ Non |
| **GeyserMC** | Velocity | Alternative à Floodgate | ❌ Non |
| **Vulcan** | Velocity | Anti-cheat (proxy) | ✅ **Oui** |
| **NoCheatPlus** | Paper | Anti-cheat (serveur) | ✅ **Oui** |
| **EssentialsX** | Paper (Lobby) | Commandes de base | ❌ Non |

## 🔗 Liens utiles

### **Plugins**
- [LuckPerms](https://luckperms.net/) (Permissions)
- [TabList](https://github.com/Exceptionflug/TabList) (Tablist)
- [AdvancedBan](https://github.com/Leako/AdvancedBan) (Bans globaux)
- [VelocityAuth](https://github.com/Patbox/VelocityAuth) (Authentification)
- [RedisBungee](https://github.com/ImaginaryDevelopment/RedisBungee) (Synchronisation)
- [Floodgate](https://github.com/GeyserMC/Floodgate) (Support Bedrock)
- [GeyserMC](https://geysermc.org/) (Proxy Bedrock → Java)
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
- [GeyserMC (Bedrock)](https://geysermc.org/docs/) (Documentation complète)

---

## 📝 Notes supplémentaires

### **Comment tester le support Bedrock ?**
1. **Sur mobile (Bedrock)** :
   - Ajoutez un serveur avec l’IP de votre machine et le port **19132**.
   - Connectez-vous et utilisez `/login <motdepasse>` ou `/register <motdepasse> <confirmation>`.

2. **Sur PC (Bedrock)** :
   - Utilisez l’application **Minecraft Bedrock Edition** (Windows 10/11, Xbox, etc.).
   - Ajoutez un serveur avec l’IP et le port **19132**.

### **Compatibilité**
- **Java** : 1.20.6 (ou toute version supportée par Paper)
- **Bedrock** : 1.20.50+ (via Floodgate/GeyserMC)
- **Velocity** : 3.3.0-SNAPSHOT (ou version compatible)
- **Paper** : 1.20.6 (ou version compatible)

### **Performances**
- **RAM recommandée** :
  - Velocity : 1-2 Go
  - Chaque serveur Paper : 2-4 Go
  - Floodgate/GeyserMC : 512 Mo - 1 Go
  - Total : 8-16 Go (selon le nombre de joueurs)

---

## 🎉 Résumé

Vous avez maintenant un serveur **Velocity + Paper** en **mode CRACK** avec :
✅ **Support Java + Bedrock** (Floodgate + GeyserMC)
✅ **Authentification unifiée** (`/login` pour tous les joueurs)
✅ **Permissions globales** (LuckPerms)
✅ **Bans inter-serveurs** (AdvancedBan)
✅ **Tablist personnalisée** (TabList)
✅ **Chat global** (RedisBungee)
✅ **Commandes de base** (EssentialsX)

**Prochaines étapes** :
1. Téléchargez les plugins avec `download_plugins.sh` ou `download_plugins.bat`.
2. Configurez `online_mode = false` dans `velocity.toml` et tous les `server.properties`.
3. Lancez les serveurs avec `start_all.sh` ou `start_all.bat`.
4. Testez la connexion depuis Java et Bedrock avec `/login` !

---

## 💡 Conseils pour un serveur CRACK

### **Sécurité**
- **Limitez les permissions** : Ne donnez pas `*` à tout le monde. Utilisez des groupes (`default`, `vip`, `mod`, `admin`).
- **Activez les bans temporaires** : Utilisez `/tempban` pour les joueurs problématiques.
- **Surveillez les logs** : Vérifiez régulièrement les logs pour détecter les abusés.

### **Optimisations**
- **Utilisez Redis** pour synchroniser les bans et le chat entre les serveurs.
- **Activez le cache** dans LuckPerms pour améliorer les performances.
- **Limitez le nombre de joueurs** par serveur (`max-players` dans `server.properties`).

### **Personnalisation**
- **Modifiez les messages** dans `velocityauth/config.toml` pour correspondre à votre thème.
- **Personnalisez la tablist** dans `tab-list/config.json` avec vos couleurs.
- **Ajoutez des warps** dans `essentials/config.yml` pour faciliter la navigation.
