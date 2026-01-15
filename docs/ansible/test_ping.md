### Test Ping Playbook

- **Objectif** : Vérifier la connectivité SSH via Tailscale
- **Fichiers** : `ansible/playbooks/test_ping.yml`
- **Exemple d’exécution** :
```bash
ansible-playbook -i inventory.ini test_ping.yml

