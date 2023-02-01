#!/usr/bin/env bash

data=$( jq --null-input -c --arg host $1 '{"common_name":$host,"alt_names":"localhost","ttl":"48h"}')

curl --silent -X PUT \
-H "X-Vault-Request: true" \
-H "X-Vault-Token: hvs.8Zpy4z7xMOlZVP6i9W72Bzoi" \
-d ${data} \
http://127.0.0.1:8200/v1/pki_int/issue/example-dot-com | jq '.data|.private_key, .certificate, .ca_chain[]' -r > certs/$1.pem
