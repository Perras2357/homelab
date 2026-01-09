## Rôle du répertoire

Le répertoire `scripts/` regroupe l’ensemble des scripts transverses utilisés pour l’exploitation, la maintenance et l’automatisation du homelab.

Ces scripts ne sont **pas spécifiques à un service** en particulier. Ils agissent à l’échelle de l’infrastructure ou de plusieurs conteneurs LXC.

---

## Typologie des scripts

### Provisioning

Scripts utilisés lors de la création ou de l’initialisation de ressources :

* création de conteneurs LXC
* application de standards communs
* préparation du système

Exemples :

* `lxc-create.sh`
* `lxc-hardening.sh`

---

### Exploitation et maintenance

Scripts destinés aux opérations récurrentes :

* mises à jour
* nettoyage
* redémarrage contrôlé

Exemples :

* `update-all.sh`
* `maintenance-lxc.sh`

---

### Sauvegarde et restauration

Scripts liés à la protection des données et à la continuité de service :

* sauvegarde globale
* déclenchement de dumps
* vérification des sauvegardes

Exemples :

* `backup-all.sh`
* `restore-postgres.sh`

---

## Conventions d’écriture

Les règles suivantes s’appliquent à l’ensemble des scripts :

* scripts écrits en Bash
* noms explicites : `verbe-perimetre.sh`
* commentaires en tête de fichier (objectif, prérequis)
* sortie explicite (logs ou echo structurés)
* scripts idempotents lorsque possible

---

## Gestion des secrets

Aucun secret (mot de passe, token, clé privée) ne doit être présent en clair dans les scripts.

Les scripts doivent utiliser :

* des variables d’environnement
* des fichiers externes non versionnés

---

## Portée et limites

Les scripts ont pour objectif de :

* simplifier l’exploitation
* réduire les erreurs humaines
* documenter les procédures

Ils ne remplacent pas un outil de configuration déclaratif (ex. Ansible), mais préparent une transition future vers ce type d’approche.

