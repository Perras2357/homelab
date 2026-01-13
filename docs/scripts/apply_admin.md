# LXC – Configuration utilisateur admin

## Objectif

Le script `apply_admin.sh` permet de :
- préparer l’accès SSH pour un utilisateur admin commun
- configurer un accès sudo sans mot de passe
- appliquer la configuration sur plusieurs conteneurs LXC Proxmox

Le tout depuis le nœud Proxmox (LXC manager).

---

## Prérequis

- Accès root sur le nœud Proxmox
- Commande `pct` disponible
- Conteneurs LXC existants et démarrés
- L’utilisateur admin déjà créé dans les conteneurs

---

## Configuration

Créer le fichier de configuration :

```bash
cp config/script.apply_admin.env.example config/script.apply_admin.env

