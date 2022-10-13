LIVEBOX_IP="192.168.1.1"
USERNAME="admin"
PASSWORD="ENTER_YOUR_PASSWORD" # To be replaced
COOKIE_SAVE_PATH="/tmp/"


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

LOGIN_RESPONSE=`curl 'http://'"${LIVEBOX_IP}"'/ws' -s -X POST -H 'User-Agent: \
Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:96.0) Gecko/20100101 Firefox/96.0' \
-H 'Accept: */*' -H 'Accept-Language: fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3' -H \
'Accept-Encoding: gzip, deflate' -H 'Authorization: X-Sah-Login' -H 'Content-T\
ype: application/x-sah-ws-4-call+json' -H 'Origin: http://'"${LIVEBOX_IP}"'' -H 'DNT\
: 1' -H 'Connection: keep-alive' -H 'Referer: http://'"${LIVEBOX_IP}"'/' -H 'C\
ookie: 3e673c0f/accept-language=fr,fr-FR; UILang=fr' --data-raw '{"service":"sa\
h.Device.Information","method":"createContext","parameters":{"applicationName":\
"webui","username":"'"${USERNAME}"'","password":"'"${PASSWORD}"'"}}' -c "${COOK\
IE_SAVE_PATH}"'.cookie_livebox'`

regex_pattern='contextID\"\:\"([^\"]+)'

[[ $LOGIN_RESPONSE =~ $regex_pattern ]]

CONTEXT_ID=${BASH_REMATCH[1]}

DISABLE_WIFI24=`curl 'http://'"${LIVEBOX_IP}"'/ws' -s -X POST -H 'User-Agent: \
Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:96.0) Gecko/20100101 Firefox/96.0' -\
H 'Accept: */*' -H 'Accept-Language: fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3' -H 'A\
ccept-Encoding: gzip, deflate' -H 'Content-Type: application/x-sah-ws-4-call+js\
on' -H 'Authorization: X-Sah '"${CONTEXT_ID}"'' -H 'X-Context: '"${CONTEXT_ID}"\
'' -H 'Origin: http://'"${LIVEBOX_IP}"'' -H 'DNT: 1' -H 'Connection: keep-alive' -H '\
Referer: http://'"${LIVEBOX_IP}"'/' -b "${COOKIE_SAVE_PATH}"'.cookie_livebox' -\
-data-raw '{"service":"NeMo.Intf.wifi0_bcm","method":"setWLANConfig","parameter\
s":{"mibs":{"penable":{"wifi0_bcm":{"Enable":false,"PersistentEnable":false},"w\
ifi0_quan":{"Enable":true,"PersistentEnable":true}}}}}'`

sleep 5

DISABLE_WIFI24_RESPONSE=`curl 'http://'"${LIVEBOX_IP}"'/ws' -s -X POST -H 'User-Agent: \
Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:96.0) Gecko/20100101 Firefox/96.0' -\
H 'Accept: */*' -H 'Accept-Language: fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3' -H 'A\
ccept-Encoding: gzip, deflate' -H 'Content-Type: application/x-sah-ws-4-call+js\
on' -H 'Authorization: X-Sah '"${CONTEXT_ID}"'' -H 'X-Context: '"${CONTEXT_ID}"\
'' -H 'Origin: http://'"${LIVEBOX_IP}"'' -H 'DNT: 1' -H 'Connection: keep-alive' -H '\
Referer: http://'"${LIVEBOX_IP}"'/' -b "${COOKIE_SAVE_PATH}"'.cookie_livebox' -\
-data-raw '{"service":"NeMo.Intf.lan","method":"getMIBs","parameters":{"mibs":"\
base wlanradio"}}'`

STATUS_WIFI24=($(echo $DISABLE_WIFI24_RESPONSE | jq '.status.wlanradio.wifi0_bcm.RadioStatus'))

if [[ $STATUS_WIFI24 == '"Down"' ]]; then
    echo "Wi-Fi 2,4Ghz disabled"
else
    echo "Disable Wi-Fi 2,4Ghz failed !"
fi

rm "${COOKIE_SAVE_PATH}"'.cookie_livebox'
