#!/usr/bin/env bash

set -euo pipefail
  

#=======================================================================================#
#											#
#	 Script de configuration réseau pour que tailscale fonctionne			#
#	 ------------------------------------------------------------			#
# 	Usage : 									#	
# 		rendre le script executable : chmod +x config_reseau_lxc.sh		#
# 		./config_reseau_lxc.sh NUM_CONTENEUR 					#	
#											#
#=======================================================================================#

  

# Vérification des paramètres 

if [ $# -ne 1 ]; then 

    echo "Usage: $0 <num_conteneur>" 

    exit 1 

fi 

  
num="$1" 
dir="."
file="${dir}/${num}.conf"

echo "[INFO] Configuration du conteneur  : $num" 

line1='contenu1'
line2='contenu2'
#--- 0. On vérifie si le fichier à configurer existe dans le repertoire ---
if [ -f "$file" ]; then
	if sudo grep -qxF "$line1" "$file" && sudo grep -qxF "$line2" "$file"; then
		echo "[INFO] Les 2 lignes existent déjà"
	else
    
		# Ajoute seulement celles qui manquent
   		sudo grep -qxF "$line1" "$file" || printf '%s\n' "$line1" | sudo tee -a "$file" >/dev/null
    		sudo grep -qxF "$line2" "$file" || printf '%s\n' "$line2" | sudo tee -a "$file" >/dev/null
    		
		pct restart $num

		echo "[OK] Lignes ajoutées et conteneur redémarré"
  	fi
else

  	echo "[WARNING] Le conteneur $num n'existe pas."
fi  
