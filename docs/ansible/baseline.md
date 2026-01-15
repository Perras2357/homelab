# Ansible Playbooks

## Playbook: Baseline LXC

**Objectif** : Mettre à jour le système et installer des paquets communs sur tous les LXC.

**Fichier** : `ansible/playbooks/baseline.yml`

**Fonctionnement** :
- Met à jour le cache apt et upgrade la distribution
- Installe les paquets suivants :
  - curl
  - vim
  - htop
  - ca-certificates
  - gnupg

**Exemple d'exécution** :

```bash
ansible-playbook -i inventory.ini ansible/playbooks/baseline.yml

