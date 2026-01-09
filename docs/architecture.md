## 1. Objectifs d’architecture

L’architecture du homelab vise à fournir un environnement :

* stable et maintenable
* proche des pratiques professionnelles
* propice à l’automatisation future
* compréhensible et documenté

Les choix techniques privilégient la clarté et la maîtrise plutôt que la complexité inutile.

---

## 2. Vue d’ensemble de l’infrastructure

* Un hyperviseur Proxmox héberge l’ensemble des services
* Chaque service est isolé dans un conteneur LXC dédié
* Une base PostgreSQL centralisée est utilisée par plusieurs services
* Les flux inter-services sont limités et explicitement maîtrisés

---

## 3. Architecture logique

### Couche virtualisation

* Proxmox VE
* Gestion des ressources (CPU, RAM, stockage)
* Sauvegardes via Proxmox Backup Server

### Couche services socles

* PostgreSQL
* OpenLDAP
* Keycloak

### Couche services applicatifs

* Nextcloud
* Postfix

### Couche supervision

* Prometheus
* Grafana
* InfluxDB

---

## 4. Architecture réseau

L’architecture réseau du homelab repose sur une combinaison entre le réseau local Proxmox et un réseau overlay sécurisé basé sur **Tailscale**.

### Réseau Proxmox (local)

* L’ensemble des conteneurs LXC utilise le **bridge réseau de l’hyperviseur Proxmox**
* Tous les LXC sont placés dans **le même sous-réseau IP**
* Ce sous-réseau est partagé avec le VPS hébergeant le **reverse proxy**

Ce choix permet :

* une communication simple et directe entre services
* l’absence de NAT interne complexe
* une exposition maîtrisée via le reverse proxy uniquement

### Réseau overlay (Tailscale)

* Tailscale est utilisé comme **réseau d’interconnexion sécurisé**
* Il permet l’accès administratif distant à l’infrastructure
* Les flux de gestion (administration, maintenance) transitent via Tailscale

Aucun service critique n’est exposé directement sur Internet sans passer par le reverse proxy.

---

## 5. Gestion des données

* PostgreSQL centralisé dans un LXC dédié
* Une base par service consommateur
* Sauvegardes régulières
* Restauration testable indépendamment des services

---

## 6. Sécurité (vue haut niveau)

* Isolation stricte des services
* Authentification centralisée (Keycloak)
* Accès administrateur limité

---

## 7. Exploitation et maintenance

* Mise à jour indépendante de chaque service
* Sauvegardes automatisées
* Scripts de maintenance transverses

---

## 8. Évolutivité

L’architecture est conçue pour permettre :

* l’introduction progressive d’Ansible
* l’automatisation du provisioning
* une éventuelle extension multi-nœuds

Certaines limites sont assumées (absence de haute disponibilité, approche mono-hyperviseur).

---

## 9. Portée et limites

Ce homelab n’a pas vocation à être une infrastructure de production critique, mais un environnement d’apprentissage avancé, structuré et maintenable, aligné avec des pratiques professionnelles.

