# DevVanillaVelocityServer

Un serveur Minecraft **Velocity** avec **4 sous-serveurs Paper** pour la version **1.20.6** prenant en charge **Java et Bedrock** :
- **Lobby** (point d'entrée pour les joueurs)
- **Survie** (mode survie classique)
- **Créatif** (mode créatif)
- **Mini-Jeux** (pour les jeux personnalisés)

**Fonctionnalités clés** :
✅ **Support Java + Bedrock** (via Floodgate)
✅ **Authentification unifiée** (`/login` pour tous les joueurs)
✅ **Permissions globales** (LuckPerms)
✅ **Bans inter-serveurs** (AdvancedBan)
✅ **Tablist personnalisée** (TabList)
✅ **Chat global** (via RedisBungee)

---

## 📁 Structure du projet

```
DevVanillaVelocityServer/
├── velocity/                          # Proxy Velocity
│   ├── velocity.toml                  # Configuration principale (ports Java + Bedrock)
│   ├── servers.json                   # Liste des sous-serveurs
│   ├── forwarding.secret              # Clé de forwarding
│   ├── start.sh                       # Lancement (Linux/macOS)
│   ├── start.bat                      # Lancement (Windows)
│   └── plugins/                       # Plugins Velocity
│       ├── luckperms/                 # ✅ Gestion des permissions
│       │   └── config.yml
│       ├── tab-list/                  # ✅ Tablist personnalisée
│       │   └── config.json
│       ├── advancedban/               # ✅ Bans inter-serveurs
│       │   └── config.yml
│       ├── velocityauth/              # ✅ Authentification unifiée
│       │   └── config.toml
│       ├── redisbungee/               # ✅ Synchronisation Redis
│       │   └── config.yml
│       └── floodgate/                  # ✅ Support Bedrock
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
- **Ports ouverts** :
  - `25577` (Velocity - Java)
  - `19132` (Velocity - Bedrock via Floodgate)
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

## 🎮 Support Java + Bedrock

### **Floodgate**
Floodgate permet aux joueurs **Bedrock** de rejoindre votre serveur **Java** via Velocity.

#### **Configuration**
- **Fichier** : `velocity/plugins/floodgate/config.yml`
- **Port Bedrock** : `19132` (configuré dans `velocity.toml`)
- **Mode** : `ONLINE` (les joueurs Bedrock doivent se connecter avec un compte Microsoft)

**Exemple de configuration** :
```yaml
# velocity/plugins/floodgate/config.yml
enabled: true
mode: ONLINE  # ONLINE, OFFLINE ou HYBRID
bedrock-port: 19132
bedrock-bind: "0.0.0.0"
welcome-message: "§aBienvenue, %player% ! Vous jouez depuis Bedrock."
bedrock-prefix: "§7[BE] "
sync-chat: true
bedrock-chat-format: "§7%prefix%%name%§7: %message%"
java-chat-format: "§7%prefix%%name%§7: %message%"
```

#### **Comment se connecter depuis Bedrock ?**
1. **Adresse** : Utilisez l’IP de votre serveur avec le port **19132** (ex: `votre-ip:19132`)
2. **Authentification** : Les joueurs Bedrock devront utiliser `/login` ou `/register` (si VelocityAuth est activé).

---

## 🔐 Authentification unifiée (`/login`)

### **VelocityAuth**
VelocityAuth permet une **authentification centralisée** pour les joueurs **Java et Bedrock** avant de rejoindre un serveur.

#### **Configuration**
- **Fichier** : `velocity/plugins/velocityauth/config.toml`
- **Mode** : `BOTH` (les joueurs peuvent s’inscrire ou se connecter)
- **Fallback** : `lobby` (les joueurs sont redirigés vers le Lobby après authentification)

**Exemple de configuration** :
```toml
# velocity/plugins/velocityauth/config.toml
enabled = true
mode = "BOTH"  # NONE, REGISTER, LOGIN ou BOTH
fallback-server = "lobby"

# Options pour les joueurs Bedrock
bedrock {
    enabled = true
    mode = "LOGIN"  # Les joueurs Bedrock doivent se connecter
    login-message = "§cVeuillez vous connecter avec /login <motdepasse>"
    register-message = "§cVeuillez vous inscrire avec /register <motdepasse> <confirmation>"
}

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

# Sécurité
security {
    hash-algorithm = "BCRYPT"
    min-password-length = 4
    prevent-multiple-logins = true
    max-login-attempts = 5
    tempban-duration = 300  # 5 minutes
}
```

#### **Commandes pour les joueurs**
| Commande | Description | Exemple |
|----------|-------------|---------|
| `/login <motdepasse>` | Se connecter | `/login monmotdepasse` |
| `/register <motdepasse> <confirmation>` | S’inscrire | `/register monmotdepasse monmotdepasse` |
| `/changepassword <ancien> <nouveau>` | Changer son mot de passe | `/changepassword ancien nouveau` |

> ⚠️ **Note** : Les joueurs **Bedrock** devront aussi utiliser ces commandes s’ils sont en mode `LOGIN` ou `BOTH`.

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
| **Floodgate** | Velocity | Support des joueurs Bedrock. | [Floodgate](https://github.com/GeyserMC/Floodgate) |
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
├── velocityauth/       # ✅ Authentification unifiée
│   └── config.toml     # Mode BOTH, fallback-server: lobby
│
├── redisbungee/        # ✅ Synchronisation Redis
│   └── config.yml      # Chat global, sync bans/permissions
│
└── floodgate/          # ✅ Support Bedrock
    └── config.yml      # Port 19132, mode ONLINE
```

#### **Lobby** (`servers/lobby/plugins/`)
```
servers/lobby/plugins/
├── luckperms/          # Permissions synchronisées
│   └── config.yml
│
└── essentials/         # Commandes de base
    └── config.yml      # Warps vers les autres serveurs
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
     host: "127.0.0.0"
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
- **Port Bedrock** : `19132` (via Floodgate)
- **MOTD** : `§6DevVanilla §8| §eVelocity Proxy (Java + Bedrock)`
- **Serveur par défaut** : `lobby`
- **Servers backend** : `lobby`, `survie`, `creatif`, `minijeux`

### **Sous-serveurs Paper**

| Serveur    | Port  | Mode       | Difficulté | PvP  | Vol | Type de monde | Description |
|------------|-------|------------|------------|------|-----|--------------|-------------|
| **Lobby**  | 25568 | Adventure  | Peaceful   | ❌   | ✅  | Flat         | Point d’entrée |
| **Survie** | 25565 | Survival   | Normal     | ✅   | ❌  | Default      | Mode survie |
| **Créatif**| 25566 | Creative   | Peaceful   | ❌   | ✅  | Flat         | Mode créatif |
| **Mini-Jeux**|25567| Adventure  | Normal     | ✅   | ❌  | Default      | Jeux personnalisés |

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

### **Authentification (`/login`)**
| Commande | Description | Exemple |
|----------|-------------|---------|
| `/login <motdepasse>` | Se connecter | `/login monmotdepasse` |
| `/register <motdepasse> <confirmation>` | S’inscrire | `/register monmotdepasse monmotdepasse` |
| `/changepassword <ancien> <nouveau>` | Changer son mot de passe | `/changepassword ancien nouveau` |

### **AdvancedBan (Bans globaux)**
| Commande | Description | Exemple |
|----------|-------------|---------|
| `/ban <joueur> <raison>` | Bannir un joueur | `/ban NotCH Triche` |
| `/tempban <joueur> <durée> <raison>` | Ban temporaire | `/tempban NotCH 1d Triche` |
| `/unban <joueur>` | Débannir un joueur | `/unban NotCH` |
| `/kick <joueur> <raison>` | Éjecter un joueur | `/kick NotCH Flood` |
| `/mute <joueur> <raison>` | Muter un joueur | `/mute NotCH Insultes` |
| `/warn <joueur> <raison>` | Avertir un joueur | `/warn NotCH Avertissement` |

### **LuckPerms (Permissions)**
| Commande | Description | Exemple |
|----------|-------------|---------|
| `/lp editor` | Ouvrir l’éditeur de permissions | `/lp editor` |
| `/lp group <nom> permission set <permission>` | Ajouter une permission | `/lp group vip permission set essentials.fly` |
| `/lp user <joueur> group add <groupe>` | Ajouter un joueur à un groupe | `/lp user Steve group add vip` |

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

### **Problèmes avec Floodgate (Bedrock)**
| Problème | Solution |
|----------|----------|
| **Les joueurs Bedrock ne peuvent pas se connecter** | Vérifiez que le port `19132` est ouvert et que Floodgate est dans `velocity/plugins/`. |
| **Erreur "Invalid session"** | Assurez-vous que `online_mode: true` est activé dans `velocity.toml`. |
| **Les joueurs Bedrock voient un message d’erreur** | Vérifiez que Floodgate est bien configuré (`mode: ONLINE`). |
| **Les joueurs Bedrock ne peuvent pas utiliser `/login`** | Vérifiez que `bedrock.enabled: true` est activé dans `velocityauth/config.toml`. |

### **Problèmes avec VelocityAuth**
| Problème | Solution |
|----------|----------|
| **Les joueurs ne sont pas redirigés après `/login`** | Vérifiez que `fallback-server: "lobby"` est bien configuré. |
| **Les joueurs Bedrock ne peuvent pas se connecter** | Vérifiez que `bedrock.mode: "LOGIN"` ou `"BOTH"` est activé. |
| **Mot de passe oublié** | Utilisez `/changepassword <ancien> <nouveau>`. |

### **Problèmes avec AdvancedBan**
| Problème | Solution |
|----------|----------|
| **Les bans ne sont pas globaux** | Utilisez MySQL ou Redis pour la synchronisation. |
| **Les modérateurs ne voient pas les bans** | Vérifiez les permissions (`advancedban.ban`, `advancedban.tempban`). |

### **Problèmes avec Redis**
| Problème | Solution |
|----------|----------|
| **Connexion refusée** | Vérifiez que Redis est lancé (`redis-server`). |
| **Mot de passe incorrect** | Vérifiez le mot de passe dans `velocity/plugins/redisbungee/config.yml`. |

---

## 🔗 Liens utiles

### **Plugins**
- [LuckPerms](https://luckperms.net/) (Permissions)
- [TabList](https://github.com/Exceptionflug/TabList) (Tablist)
- [AdvancedBan](https://github.com/Leako/AdvancedBan) (Bans globaux)
- [VelocityAuth](https://github.com/Patbox/VelocityAuth) (Authentification)
- [RedisBungee](https://github.com/ImaginaryDevelopment/RedisBungee) (Synchronisation)
- [Floodgate](https://github.com/GeyserMC/Floodgate) (Support Bedrock)
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
- [GeyserMC (Bedrock)](https://geysermc.org/) (Documentation Floodgate)

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
- **Bedrock** : 1.20.50+ (via Floodgate)
- **Velocity** : 3.3.0-SNAPSHOT (ou version compatible)
- **Paper** : 1.20.6 (ou version compatible)

### **Performances**
- **RAM recommandée** :
  - Velocity : 1-2 Go
  - Chaque serveur Paper : 2-4 Go
  - Total : 8-16 Go (selon le nombre de joueurs)

---

## 🎉 Résumé

Vous avez maintenant un serveur **Velocity + Paper** avec :
✅ **Support Java + Bedrock** (Floodgate)
✅ **Authentification unifiée** (`/login` pour tous)
✅ **Permissions globales** (LuckPerms)
✅ **Bans inter-serveurs** (AdvancedBan)
✅ **Tablist personnalisée** (TabList)
✅ **Chat global** (RedisBungee)
✅ **Commandes de base** (EssentialsX)

**Prochaines étapes** :
1. Téléchargez les plugins avec `download_plugins.sh` ou `download_plugins.bat`.
2. Configurez MySQL/Redis pour la synchronisation globale.
3. Lancez les serveurs avec `start_all.sh` ou `start_all.bat`.
4. Testez la connexion depuis Java et Bedrock !
