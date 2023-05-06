# docker-GLPI
## Objectifs

L'objectif principal de ce projet était de m'entrainer à la manipulation de Dockerfile et docker-composer.yml.
Il n'a, en l'état, pas pour objectif d'être utilisé en prodution, de par le simple fait que le protocole HTTPS ne soit pas implémenté lors de la publication.

## Mise en place
Télécharger l'ensemble de de repository à l'aide de l'une, ou l'autre, des commandes suivantes : 

> https://github.com/Xaaavier/docker-GLPI.git

> https://github.com/Xaaavier/docker-GLPI/archive/refs/heads/main.zip && unzip main.zip

Lancer le script d'installation : 

> sudo ./glpi.sh --install

Une fois la commande lancé, le script est autonome pour une grande partie du travail, trois éléments doivent lui être indiqués : 
- l'URL où téléchatger GLPI (format tar.gz)
- le nom de la base de donnée à créer
- le nom de l'utilisateur autorisé à se connecter à cette base de donnée.

D'autres options sont disponibles : 
- --help : pour obtenir de l'aide
- --update : pour réaliser une mise a jour de GLPI (noon testé)

## Que fait le script ?
Le script vérifie dans un premier temps si docker est présent, s'il ne l'est pas il l'installera (compatible avec les version officiellement supporté par docker de Debian et Ubuntu) et vérifiera le fonctionnement du démon.

Une fois l'URL de téléchargement fourni, il s'occupera de récupérer l'archige, la décomprésser et mettre en place des différents éléments nécéssaies au fonctionnement de GLPI en respectant l'ensemble des points de sécurité exigé par GLPI (emplacement de la racine du serveur WEB, extensions PHP, ...).

Pour terminer, le script mettera automatiquement en place l'utilisation des fuseau horraire et de redis.
