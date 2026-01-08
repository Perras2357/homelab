# Homelab – Infrastructure Proxmox

## Objectif
Ce dépôt documente et automatise mon infrastructure homelab basée sur Proxmox VE
et des conteneurs LXC.

## Architecture globale
- Hyperviseur : Proxmox VE
- Virtualisation : LXC & VM
- Base de données centralisée : PostgreSQL (LXC dédié)
- Authentification : OpenLDAP + Keycloak
- Supervision : Prometheus / Grafana / InfluxDB
- Sauvegarde : Proxmox Backup Server
