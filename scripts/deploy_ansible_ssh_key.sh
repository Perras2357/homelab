#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

ENV_FILE="$ROOT_DIR/config/script.deploy_ansible_ssh_key.env"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "[ERREUR] Fichier de configuration manquant : $ENV_FILE"
  exit 1
fi

# shellcheck disable=SC1090
source "$ENV_FILE"

if [[ -z "${LXC_IPS:-}" ]]; then
  echo "[ERREUR] Variable LXC_IPS non définie dans deploy_ansible_ssh_key.env"
  exit 1
fi

if [[ ! -f "$ANSIBLE_SSH_KEY" ]]; then
  echo "[ERREUR] Clé SSH introuvable : $ANSIBLE_SSH_KEY"
  exit 1
fi

for IP in $LXC_IPS; do
  echo "[INFO] Déploiement clé SSH vers $ADMIN_USER@$IP"

  ssh-copy-id \
    -i "$ANSIBLE_SSH_KEY" \
    -o StrictHostKeyChecking=accept-new \
    "$ADMIN_USER@$IP"

  echo "[OK] Clé SSH déployée sur $IP"
done

