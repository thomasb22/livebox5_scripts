# Livebox 5 Scripts

Ceci est une bifurcation de ce projet : https://github.com/PabloLec/livebox5_reboot

## livebox_reboot.sh

Ce script bash vous permet de redémarrer à distance votre Livebox 5 depuis un périphérique de votre réseau local.
La seule dépendance est `curl`.

Testé sur Livebox 5 firmware 4.34.0 et 4.53.14

### Utilisation

- Téléchargez le script `livebox_reboot.sh`
- Modifiez le placeholder par votre mot de passe dans `PASSWORD="ENTER_YOUR_PASSWORD"`
- Au besoin, modifiez l'username ou l'IP de votre Livebox
- Lancez le script

## livebox_disable_wifi_2_4Ghz.sh

Ce script bash vous permet de désactiver l'antenne Wi-Fi 2,4Ghz à distance sur votre Livebox 5 depuis un périphérique de votre réseau local.
Les seules dépendances sont `curl` et `jq`.

Testé sur Livebox 5 firmware 4.53.14

### Utilisation

- Téléchargez le script `livebox_disable_wifi_2_4Ghz.sh`
- Modifiez le placeholder par votre mot de passe dans `PASSWORD="ENTER_YOUR_PASSWORD"`
- Au besoin, modifiez l'username ou l'IP de votre Livebox
- Lancez le script

## Contribution

Si vous rencontrez un problème lors de l'utilisation ou si vous avez une suggestion, n'hésitez pas à ouvrir une Issue.
