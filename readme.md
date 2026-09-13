# Documentation

Ce projet s'exécute dans un container Docker afin que tout le monde dispose exactement du même environnement Python, quels que soient l'OS et la version de Python installés sur la machine.

Réutilisez-le pour les exercices vus en cours.

**Un fichier Makefile est inclus pour faciliter l'exécution des commandes. La commnde `make` est généralement déjà disponible, mais il peut-être nécessaire de l'installer avec apt/yum...**

## Prérequis

Le projet nécessite Docker, Docker Compose (https://docs.docker.com/engine/install/) et make (souvent installé par défaut).

Attention à bien suivre également les étapes post-installation de Docker : 
https://docs.docker.com/engine/install/linux-postinstall/

Pour les étudiants sous Windows, il est conseillé d'installer Docker dans WSL2 (distribution Debian, Arch...), sans passer par Docker Desktop, ou d'utiliser une VM.


## Premier lancement

### 1. Configurer l'UID/GID

Par défaut, le container tourne avec l'utilisateur `root`. Pour éviter des problèmes de permissions, nous allons utiliser dans le container un utilisateur `dev` ayant le même UID (User ID) et GID (Group ID) que votre utilisateur système. Pour se faire, lancez cette commande dans votre dossier pour initialiser un .env :

```sh
make env
```

### 2. Construire l'image

```sh
make build
```

Cette étape crée l'utilisateur `dev` avec votre UID/GID et installe les dépendances listées dans `requirements.txt` à l'intérieur de l'image. **Ne modifiez pas directement ce ficheir (cf paragraphe "Ajouter une dépendance").**

### 3. Démarrer le container

```sh
make up
```

Le container tourne désormais en arrière-plan (`tail -f /dev/null` le maintient actif).

### 4. Ouvrir un shell dans le container

```sh
make sh
```

Le dossier en cours est `/workspace`, et correspond au dossier `./src` de votre hôte.
Vous devriez pouvoir utiliser les commandes Python dans le shell en cours.

### 5. Arrêter le container en fin de cours

```sh
make down
```

### 6. Nettoyer votre poste après ce module

```sh
make clean
```

## Ajouter une dépendance

Pour ajouter une dépendance :

1. Ajoutez la dépendance au fichier requirements.in (**pas le fichier .txt !**)
2. `make lock` 
3. `make rebuild`

