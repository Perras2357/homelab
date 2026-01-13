#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

ENV_FILE="$ROOT_DIR/config/script.apply_admin.env"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "[ERREUR] Fichier de configuration manquant : $ENV_FILE"
  echo "Copie config/script.apply_admin.env.example vers config/script.apply_admin.env"
  exit 1
fi

# Chargement des variables
# shellcheck disable=SC1090
source "$ENV_FILE"

for CT in $LXC_IDS; do
  echo "[INFO] Traitement du conteneur LXC $CT"

  STATUS=$(pct status "$CT" 2>/dev/null || true)

  if [[ "$STATUS" != *"running"* ]]; then
    echo "[SKIP] CT $CT non existant ou arrêté"
    continue
  fi

# -----------------------------
  # Préparer le SSH de l'utilisateur admin
  # -----------------------------
  pct exec "$CT" -- bash -c "
    mkdir -p /home/$ADMIN_USER/.ssh &&
    touch /home/$ADMIN_USER/.ssh/authorized_keys &&
    chown -R $ADMIN_USER:$ADMIN_USER /home/$ADMIN_USER/.ssh &&
    chmod 700 /home/$ADMIN_USER/.ssh &&
    chmod 600 /home/$ADMIN_USER/.ssh/authorized_keys
  "
  echo "[OK] Dossier .ssh et authorized_keys préparés pour $ADMIN_USER sur CT $CT"



  pct exec "$CT" -- bash -c "
    echo '$ADMIN_USER ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/$ADMIN_USER &&
    chmod 440 /etc/sudoers.d/$ADMIN_USER &&
    visudo -cf /etc/sudoers.d/$ADMIN_USER
  "

  echo "[OK] sudoers configuré sur CT $CT"
done

