#!/bin/bash 

  

#=======================================================================================#
#											#
#	 Script de création de l'utilisateur adminsys					#
#	 --------------------------------------------					#
# 	Usage : 									#	
# 		rendre le script executable : chmod +x create_user_lxc.sh		#
# 		./create_user_lxc.sh adminsys 1001 					#	
#											#
#=======================================================================================#

  

# Vérification des paramètres 

if [ $# -ne 2 ]; then 

    echo "Usage: $0 <nom_utilisateur> <uid/gid>" 

    exit 1 

fi 

  

USER_NAME="$1" 

USER_ID="$2"

HOME_DIR="/home/$USER_NAME" 

SSH_DIR="$HOME_DIR/.ssh" 

AUTH_KEYS="$SSH_DIR/authorized_keys" 

  

echo "[INFO] Configuration de l'utilisateur : $USER_NAME (UID/GID = $USER_ID)" 



#--- 0. Creation de l'utilisateur s'il n'existe pas ---
if ! id -u "$USER_NAME" >/dev/null 2>&1; then 

    echo "[INFO] L'utilisateur $USER_NAME n'existe pas. Création de l'utilisateur." 

    adduser "$USER_NAME"

else 

    echo "[INFO] L'utilisateur $USER_NAME existe déjà." 

fi
  

# --- 1. Ajouter au groupe sudo --- 

echo "[INFO] Ajout de $USER_NAME au groupe sudo" 

usermod -aG sudo "$USER_NAME" 

  

# --- 2. Vérifier appartenance --- 

echo "[INFO] Groupes de l'utilisateur :" 

groups "$USER_NAME" 

  

# --- 3. Changer UID et GID --- 

echo "[INFO] Changement UID / GID" 

usermod -u "$USER_ID" "$USER_NAME" 

groupmod -g "$USER_ID" "$USER_NAME" 

  

# --- 4. Config SSH --- 

echo "[INFO] Configuration SSH dans /etc/ssh/sshd_config" 

sed -i 's/^PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config 

sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config 

  

# Si les lignes n’existent pas, on les ajoute 

grep -q "^PermitRootLogin" /etc/ssh/sshd_config || echo "PermitRootLogin no" >> /etc/ssh/sshd_config 

grep -q "^PasswordAuthentication" /etc/ssh/sshd_config || echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config 

  

systemctl restart ssh 

  

# --- 5. Création du .ssh + permissions --- 

echo "[INFO] Configuration des clés SSH" 

mkdir -p "$SSH_DIR" 

chmod 700 "$SSH_DIR" 

  

touch "$AUTH_KEYS" 

chmod 600 "$AUTH_KEYS" 

chown -R "$USER_NAME:$USER_NAME" "$SSH_DIR" 

  

echo "[OK] Script terminé. L'utilisateur $USER_NAME est configuré." 

 

