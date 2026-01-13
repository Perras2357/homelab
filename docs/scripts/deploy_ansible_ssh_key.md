# Scripts Ansible – Gestion SSH

## deploy_ansible_ssh_key.sh

### Objectif

Déployer une clé SSH Ansible sur un ensemble de conteneurs LXC afin de permettre
l’exécution d’Ansible sans mot de passe.

Le script utilise `ssh-copy-id` et s’appuie sur un fichier de configuration externe.

---

### Prérequis

- Accès SSH fonctionnel vers les conteneurs
- Clé SSH Ansible déjà générée
- Utilisateur administrateur existant sur les conteneurs
- Paquet `openssh-client` installé

---

### Configuration

Créer le fichier suivant :

```bash
config/script.deploy_ansible_ssh_key.env

