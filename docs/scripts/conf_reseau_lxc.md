# LXC – Configuration réseau LXC

## Objectif

Le script `conf_reseau_lxc.sh` permet de :
- Permet d'autoriser et d'exposer les conteneurs LXC le périphérique nécessaire pour faire du tunneling réseau (Tailscale)
- La première ligne autorise le conteneur à utiliser un périphérique de type caractère (c)
- Ça fait un bind-mount du device du host vers le conteneur :rendre le device /dev/net/tun visible dans le conteneur
- Rédémarre le conteneur après configuration
---

## Prérequis

- Accès root sur le nœud Proxmox
- Commande `pct` disponible
- Conteneurs LXC existants et démarrés

---

## Configuration

emplacer le contenu des variables :

```bash

-   dir : repertoire de configuration lxc (/etc/pve/lxc/num_conteneur
-   ligne1 : lxc.cgroup2.devices.allow: c 10:200 rwm
-   ligne2 : lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file
