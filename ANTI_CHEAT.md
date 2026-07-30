# Anti-Cheat : NoCheatPlus + Vulcan

Ce fichier explique comment configurer et utiliser **NoCheatPlus** (pour Paper) et **Vulcan** (pour Velocity) pour protéger votre serveur contre les triches.

---

## 🛡️ NoCheatPlus (Paper)

NoCheatPlus est un **anti-cheat open-source** pour les serveurs **Paper/Spigot/Bukkit**. Il détecte les triches comme le fly, le speed, le kill aura, le reach, etc.

### **Installation**
1. Téléchargez **NoCheatPlus** depuis [SpigotMC](https://www.spigotmc.org/resources/nocheatplus.19289/) ou utilisez le script `download_plugins.sh`/`download_plugins.bat`.
2. Placez le fichier `.jar` dans le dossier `plugins/` de chaque sous-serveur :
   - `servers/lobby/plugins/nocheatplus.jar`
   - `servers/survie/plugins/nocheatplus.jar`
   - `servers/creatif/plugins/nocheatplus.jar`
   - `servers/minijeux/plugins/nocheatplus.jar`
3. Redémarrez chaque serveur Paper.

---

### **Configuration**

#### **Fichiers de configuration**
Chaque sous-serveur a son propre fichier de configuration :
- `servers/lobby/plugins/nocheatplus/config.yml`
- `servers/survie/plugins/nocheatplus/config.yml`
- `servers/creatif/plugins/nocheatplus/config.yml`
- `servers/minijeux/plugins/nocheatplus/config.yml`

#### **Exemple pour le Lobby**
```yaml
# Configuration de base
enabled: true
general:
  locale: fr_FR
  logging: true
  log-level: INFO

# Détection des mouvements
detection:
  movement:
    fly:
      enabled: true
      max-violations: 5
      message: "§cFly détecté !"
    speed:
      enabled: true
      max-violations: 5
      message: "§cSpeed détecté !"
    sprint-fly:
      enabled: true
      max-violations: 5
      message: "§cSprint Fly détecté !"
    step:
      enabled: true
      max-height: 0.6
      max-violations: 3
      message: "§cStep trop haut !"

# Détection des combats
  combat:
    kill-aura:
      enabled: true
      max-cps: 20
      max-violations: 5
      message: "§cKill Aura détecté !"
    reach:
      enabled: true
      max-reach: 3.5
      max-violations: 5
      message: "§cReach trop long !"

# Punitions
punishments:
  default-type: KICK
  default-ban-duration: 0
  default-kick-message: "§cTriche détectée !"
```

#### **Exemple pour Survie (plus strict)**
```yaml
detection:
  movement:
    fly:
      enabled: true
      max-violations: 3
      ban-duration: 3600  # Ban de 1 heure
      message: "§cFly détecté ! (Survie)"
    speed:
      enabled: true
      max-violations: 3
      message: "§cSpeed détecté ! (Survie)"
    step:
      enabled: true
      max-height: 0.5  # Plus strict
      max-violations: 2
      message: "§cStep trop haut ! (Survie)"

  combat:
    kill-aura:
      enabled: true
      max-cps: 15  # Plus strict
      max-violations: 3
      message: "§cKill Aura détecté ! (Survie)"
    reach:
      enabled: true
      max-reach: 3.2  # Plus strict
      max-violations: 3
      message: "§cReach trop long ! (Survie)"

punishments:
  default-type: BAN
  default-ban-duration: 3600
```

#### **Exemple pour Créatif (moins strict)**
```yaml
detection:
  movement:
    fly:
      enabled: false  # Désactivé en créatif (les joueurs peuvent voler)
    speed:
      enabled: true
      max-violations: 10  # Plus tolérant
      message: "§cSpeed détecté ! (Créatif)"

  combat:
    kill-aura:
      enabled: true
      max-cps: 25  # Plus tolérant
      max-violations: 10
      message: "§cKill Aura détecté ! (Créatif)"
    reach:
      enabled: true
      max-reach: 4.0  # Plus tolérant
      max-violations: 10
      message: "§cReach trop long ! (Créatif)"

punishments:
  default-type: KICK
  default-ban-duration: 0
```

---

### **Commandes NoCheatPlus**

| Commande | Description | Permission |
|----------|-------------|------------|
| `/ncp reload` | Recharger la configuration | `nocheatplus.admin` |
| `/ncp check <joueur>` | Vérifier un joueur | `nocheatplus.admin` |
| `/ncp bypass <joueur>` | Ajouter un joueur à la liste de bypass | `nocheatplus.admin` |
| `/ncp unbyass <joueur>` | Retirer un joueur de la liste de bypass | `nocheatplus.admin` |
| `/ncp status` | Voir le statut de NoCheatPlus | `nocheatplus.admin` |

---

### **Permissions NoCheatPlus**

| Permission | Description |
|------------|-------------|
| `nocheatplus.admin` | Accès à toutes les commandes admin |
| `nocheatplus.bypass` | Permet de bypasser NoCheatPlus |
| `nocheatplus.notify` | Recevoir les notifications des violations |

---

## 🔥 Vulcan (Velocity)

Vulcan est un **anti-cheat moderne** qui fonctionne au niveau du **proxy (Velocity)**. Il détecte les triches **avant** qu'elles n'atteignent les serveurs Paper, ce qui le rend très efficace contre les cheats clients.

### **Installation**
1. Téléchargez **Vulcan** depuis [GitHub](https://github.com/Patbox/Vulcan/releases) ou utilisez le script `download_plugins.sh`/`download_plugins.bat`.
2. Placez le fichier `.jar` dans `velocity/plugins/vulcan.jar`.
3. Redémarrez Velocity.

---

### **Configuration**

#### **Fichier de configuration**
- `velocity/plugins/vulcan/config.yml`

#### **Exemple de configuration**
```yaml
# Activer ou désactiver Vulcan
enabled: true

# Options générales
general:
  locale: en_US
  logging: true
  log-level: INFO

# Détection des mouvements
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
    
    sprint-fly:
      enabled: true
      sensitivity: 7
      max-violations: 5
      message: "§cSprint Fly détecté par Vulcan !"
    
    nofall:
      enabled: true
      sensitivity: 7
      max-violations: 5
      message: "§cNoFall détecté par Vulcan !"

  # Détection des combats
  combat:
    kill-aura:
      enabled: true
      sensitivity: 7
      max-cps: 20
      max-violations: 5
      message: "§cKill Aura détecté par Vulcan !"
    
    reach:
      enabled: true
      sensitivity: 7
      max-reach: 3.5
      max-violations: 5
      message: "§cReach trop long détecté par Vulcan !"
    
    criticals:
      enabled: true
      sensitivity: 7
      max-violations: 5
      message: "§cCriticals illégaux détectés par Vulcan !"

  # Détection des paquets
  packets:
    illegal-packets:
      enabled: true
      max-violations: 3
      punishment: BAN
      ban-duration: 3600
      message: "§cPaquets illégaux détectés par Vulcan !"
    
    packet-spam:
      enabled: true
      max-packets-per-second: 100
      max-violations: 5
      punishment: KICK
      message: "§cSpam de paquets détecté par Vulcan !"

  # Détection des connexions
  connection:
    enabled: true
    fast-connect:
      enabled: true
      max-connections-per-minute: 10
      max-violations: 3
      punishment: BAN
      ban-duration: 3600
      message: "§cConnexions trop rapides détectées par Vulcan !"

# Punitions
punishments:
  default-type: KICK
  default-ban-duration: 3600
  default-kick-message: "§cTriche détectée par Vulcan !"
  default-ban-message: "§cBanni pour triche par Vulcan !"

# Notifications
notifications:
  notify-on-violation: true
  notify-permission: "vulcan.notify"

# Bypass
bypass:
  allow-bypass: true
  bypass-permission: "vulcan.bypass"

# Performance
performance:
  cache-enabled: true
  cache-lifetime: 300

# Compatibilité
compatibility:
  allow-bedrock: true
  allow-offline-mode: true
```

---

### **Commandes Vulcan**

| Commande | Description | Permission |
|----------|-------------|------------|
| `/vulcan reload` | Recharger la configuration | `vulcan.admin` |
| `/vulcan check <joueur>` | Vérifier un joueur | `vulcan.admin` |
| `/vulcan alert <joueur>` | Envoyer une alerte pour un joueur | `vulcan.admin` |
| `/vulcan history <joueur>` | Voir l'historique des violations d'un joueur | `vulcan.admin` |

---

### **Permissions Vulcan**

| Permission | Description |
|------------|-------------|
| `vulcan.admin` | Accès à toutes les commandes admin |
| `vulcan.bypass` | Permet de bypasser Vulcan |
| `vulcan.notify` | Recevoir les notifications des violations |

---

## 📊 Comparaison NoCheatPlus vs Vulcan

| Fonctionnalité | NoCheatPlus | Vulcan |
|---------------|-------------|--------|
| **Niveau** | Paper (serveur) | Velocity (proxy) |
| **Détection du fly** | ✅ Oui | ✅ Oui |
| **Détection du speed** | ✅ Oui | ✅ Oui |
| **Détection du kill aura** | ✅ Oui | ✅ Oui |
| **Détection du reach** | ✅ Oui | ✅ Oui |
| **Détection des paquets illégaux** | ❌ Non | ✅ Oui |
| **Détection des connexions rapides** | ❌ Non | ✅ Oui |
| **Détection du nofall** | ✅ Oui | ✅ Oui |
| **Détection du sprint fly** | ✅ Oui | ✅ Oui |
| **Configuration par serveur** | ✅ Oui | ❌ Non (global) |
| **Recommandé pour** | Survie, Créatif, Mini-Jeux | Velocity (tous les serveurs) |

> **💡 Conseil** : Utilisez **les deux** pour une protection maximale !
> - **NoCheatPlus** détecte les triches **au niveau du serveur** (ex: interactions avec les blocs, combats).
> - **Vulcan** détecte les triches **au niveau du proxy** (ex: paquets illégaux, connexions rapides).

---

## 🎯 Recommandations

### **Pour un serveur Survie**
- **NoCheatPlus** : Configuration **stricte** (ban après 3 violations).
- **Vulcan** : Configuration **stricte** (sensibilité à 7-8).

### **Pour un serveur Créatif**
- **NoCheatPlus** : Configuration **moins stricte** (désactivez le fly, kick au lieu de ban).
- **Vulcan** : Configuration **modérée** (sensibilité à 5-6).

### **Pour un serveur Mini-Jeux**
- **NoCheatPlus** : Configuration **adaptée** (désactivez le nofall pour le parkour).
- **Vulcan** : Configuration **modérée** (sensibilité à 6-7).

---

## ⚠️ Résolution des problèmes

### **NoCheatPlus**
| Problème | Solution |
|----------|----------|
| **Faux positifs** | Réduisez la sensibilité ou augmentez `max-violations`. |
| **NoCheatPlus ne se charge pas** | Vérifiez que le `.jar` est dans le bon dossier `plugins/`. |
| **Les joueurs sont kickés sans raison** | Vérifiez les logs (`logs/nocheatplus.log`). |
| **Les commandes ne fonctionnent pas** | Vérifiez les permissions (`nocheatplus.admin`). |

### **Vulcan**
| Problème | Solution |
|----------|----------|
| **Faux positifs** | Réduisez la `sensitivity` (ex: passez de 7 à 5). |
| **Vulcan ne se charge pas** | Vérifiez que le `.jar` est dans `velocity/plugins/`. |
| **Les joueurs sont bannis sans raison** | Vérifiez les logs (`velocity/logs/vulcan.log`). |
| **Les notifications ne s'affichent pas** | Vérifiez la permission `vulcan.notify`. |

---

## 🔗 Liens utiles

- [NoCheatPlus (SpigotMC)](https://www.spigotmc.org/resources/nocheatplus.19289/) – Page officielle
- [NoCheatPlus (GitHub)](https://github.com/NoCheatPlus/NoCheatPlus) – Repository GitHub
- [Vulcan (GitHub)](https://github.com/Patbox/Vulcan) – Repository GitHub
- [Vulcan (Releases)](https://github.com/Patbox/Vulcan/releases) – Téléchargement

---

## 📌 Notes supplémentaires

### **Optimisation des performances**
- **NoCheatPlus** : Utilise peu de ressources CPU/RAM.
- **Vulcan** : Peut consommer un peu plus de CPU, mais reste léger.
- **Conseil** : Si vous avez beaucoup de joueurs, réduisez la `sensitivity` dans Vulcan.

### **Compatibilité avec Bedrock**
- **NoCheatPlus** : Fonctionne avec Floodgate/GeyserMC si `allow-bedrock: true` est activé.
- **Vulcan** : Fonctionne nativement avec Floodgate/GeyserMC si `allow-bedrock: true` est activé.

### **Mises à jour**
- **NoCheatPlus** : Mises à jour fréquentes sur SpigotMC.
- **Vulcan** : Mises à jour régulières sur GitHub.
- **Conseil** : Vérifiez les mises à jour régulièrement pour rester protégé contre les nouveaux cheats.
