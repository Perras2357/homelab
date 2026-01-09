## Homelab – Infrastructure Proxmox & LXC

### Objectif du dépôt

Ce dépôt Git constitue la source de vérité technique de mon homelab. Il documente l’architecture, les standards et les mécanismes de déploiement des services hébergés sur une infrastructure Proxmox.

La documentation fonctionnelle et explicative est maintenue dans mon [Wiki personne](https://wiki.perras.fr/shelves/services-conteneurs). Ce dépôt se concentre volontairement sur le **comment** (organisation, automatisation, configuration reproductible).

---

### Stack technique (vue d’ensemble)

* Hyperviseur : Proxmox VE
* Virtualisation : conteneurs LXC & VM
* Base de données : PostgreSQL centralisée (LXC dédié)
* Authentification : OpenLDAP, Keycloak
* Supervision : Grafana, InfluxDB
* Sauvegarde : Proxmox Backup Server

---

### Architecture globale

L’infrastructure repose sur une séparation stricte des responsabilités :

* 1 service = 1 conteneur LXC
* Services socles isolés des services applicatifs
* Données centralisées lorsque pertinent

Une description détaillée est disponible dans `docs/architecture.md`.

---

### Organisation du dépôt

```
proxmox/    -> standards et organisation Proxmox
lxc/        -> un dossier par service LXC
scripts/    -> scripts transverses (backup, maintenance, provisioning)
docs/       -> documentation d’architecture
```

---

### Principes directeurs

* Simplicité opérationnelle
* Reproductibilité
* Séparation des responsabilités

---

### Public cible

* Relecteur technique
* Recruteur / évaluateur infra


