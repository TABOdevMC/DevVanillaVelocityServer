# Liste des Plugins et Liens de Téléchargement

Ce fichier contient les **liens de téléchargement directs** pour tous les plugins utilisés dans ce projet.
Vous pouvez télécharger manuellement les `.jar` ou utiliser les scripts `download_plugins.sh`/`download_plugins.bat`.

---

## 📥 Téléchargement automatique

### **Linux/macOS**
```bash
chmod +x download_plugins.sh
./download_plugins.sh
```

### **Windows**
```cmd
download_plugins.bat
```

---

## 📁 Plugins pour Velocity

| Plugin | Version | Lien de téléchargement | Dossier de destination |
|--------|---------|-----------------------|-----------------------|
| **Velocity** | 3.3.0-SNAPSHOT | [Télécharger](https://papermc.io/downloads#Velocity) | `velocity/velocity.jar` |
| **LuckPerms** | 5.4.100 | [Télécharger](https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.4.100.jar) | `velocity/plugins/luckperms.jar` |
| **TabList** | 3.0.0 | [Télécharger](https://github.com/Exceptionflug/TabList/releases/download/3.0.0/TabList-3.0.0.jar) | `velocity/plugins/tab-list.jar` |
| **AdvancedBan** | 2.1.6 | [Télécharger](https://github.com/Leako/AdvancedBan/releases/download/2.1.6/AdvancedBan-2.1.6.jar) | `velocity/plugins/advancedban.jar` |
| **VelocityAuth** | 2.0.0 | [Télécharger](https://github.com/Patbox/VelocityAuth/releases/download/2.0.0/VelocityAuth-2.0.0.jar) | `velocity/plugins/velocityauth.jar` |
| **RedisBungee** | 1.0.0 | [Télécharger](https://github.com/ImaginaryDevelopment/RedisBungee/releases/download/1.0.0/RedisBungee-1.0.0.jar) | `velocity/plugins/redisbungee.jar` |
| **Floodgate** | 2.2.1 | [Télécharger](https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/bootstrap/velocity/build/libs/floodgate-velocity-2.2.1.jar) | `velocity/plugins/floodgate.jar` |
| **GeyserMC** | 2.2.0-SNAPSHOT | [Télécharger](https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/velocity/build/libs/geyser-velocity-2.2.0-SNAPSHOT.jar) | `velocity/plugins/geyser.jar` |
| **Vulcan** | 1.4.0 | [Télécharger](https://github.com/Patbox/Vulcan/releases/download/1.4.0/Vulcan-1.4.0.jar) | `velocity/plugins/vulcan.jar` |

---

## 📁 Plugins pour Paper (Lobby)

| Plugin | Version | Lien de téléchargement | Dossier de destination |
|--------|---------|-----------------------|-----------------------|
| **Paper** | 1.20.6 | [Télécharger](https://papermc.io/downloads) | `servers/lobby/paper.jar` |
| **LuckPerms** | 5.4.100 | [Télécharger](https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.4.100.jar) | `servers/lobby/plugins/luckperms.jar` |
| **EssentialsX** | 2.20.1 | [Télécharger](https://ci.ender.zone/job/EssentialsX/lastSuccessfulBuild/artifact/EssentialsX-2.20.1.jar) | `servers/lobby/plugins/essentials.jar` |
| **NoCheatPlus** | 3.16.1 | [Télécharger](https://ci.dmulloy2.net/job/NoCheatPlus/lastSuccessfulBuild/artifact/NoCheatPlus-3.16.1.jar) | `servers/lobby/plugins/nocheatplus.jar` |

---

## 📁 Plugins pour Paper (Survie, Créatif, Mini-Jeux)

| Plugin | Version | Lien de téléchargement | Dossier de destination |
|--------|---------|-----------------------|-----------------------|
| **Paper** | 1.20.6 | [Télécharger](https://papermc.io/downloads) | `servers/<nom>/paper.jar` |
| **LuckPerms** | 5.4.100 | [Télécharger](https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.4.100.jar) | `servers/<nom>/plugins/luckperms.jar` |
| **NoCheatPlus** | 3.16.1 | [Télécharger](https://ci.dmulloy2.net/job/NoCheatPlus/lastSuccessfulBuild/artifact/NoCheatPlus-3.16.1.jar) | `servers/<nom>/plugins/nocheatplus.jar` |

> **Note** : Remplacez `<nom>` par `survie`, `creatif` ou `minijeux`.

---

## 🛡️ Plugins Anti-Cheat

| Plugin | Version | Lien de téléchargement | Dossier de destination | Type |
|--------|---------|-----------------------|-----------------------|------|
| **Vulcan** | 1.4.0 | [Télécharger](https://github.com/Patbox/Vulcan/releases/download/1.4.0/Vulcan-1.4.0.jar) | `velocity/plugins/vulcan.jar` | Proxy |
| **NoCheatPlus** | 3.16.1 | [Télécharger](https://ci.dmulloy2.net/job/NoCheatPlus/lastSuccessfulBuild/artifact/NoCheatPlus-3.16.1.jar) | `servers/<nom>/plugins/nocheatplus.jar` | Serveur |

---

## 📌 Instructions manuelles

Si vous préférez télécharger les plugins manuellement :

1. **Créez les dossiers** si ils n'existent pas :
   ```bash
   mkdir -p velocity/plugins servers/lobby/plugins servers/survie/plugins servers/creatif/plugins servers/minijeux/plugins
   ```

2. **Téléchargez chaque plugin** depuis les liens ci-dessus et placez-les dans les dossiers correspondants.

3. **Renommez les fichiers** en `.jar` si nécessaire (ex: `NoCheatPlus-3.16.1.jar` → `nocheatplus.jar`).

---

## ⚠️ Notes importantes

1. **Les liens peuvent changer** : Les liens ci-dessus pointent vers les dernières versions stables au moment de la rédaction. Si un lien est obsolète, vérifiez les dernières versions sur les sites officiels.

2. **Vérifiez les dépendances** : Certains plugins nécessitent des dépendances (ex: Vault pour EssentialsX). Assurez-vous de les télécharger aussi.

3. **Compatibilité** : Tous les plugins listés ici sont compatibles avec **Minecraft 1.20.6** et **Paper/Velocity 3.3.0-SNAPSHOT**.

4. **Mises à jour** : Pour mettre à jour un plugin, téléchargez simplement la nouvelle version et remplacez l'ancienne.

---

## 🔗 Liens officiels

- [Velocity](https://papermc.io/downloads#Velocity)
- [Paper](https://papermc.io/downloads)
- [LuckPerms](https://luckperms.net/)
- [TabList](https://github.com/Exceptionflug/TabList)
- [AdvancedBan](https://github.com/Leako/AdvancedBan)
- [VelocityAuth](https://github.com/Patbox/VelocityAuth)
- [RedisBungee](https://github.com/ImaginaryDevelopment/RedisBungee)
- [Floodgate](https://github.com/GeyserMC/Floodgate)
- [GeyserMC](https://geysermc.org/)
- [Vulcan](https://github.com/Patbox/Vulcan)
- [NoCheatPlus](https://www.spigotmc.org/resources/nocheatplus.19289/)
- [EssentialsX](https://essentialsx.net/)
