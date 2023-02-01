# issue using vault
vault write pki_int/issue/example-dot-com common_name="test.example.com" ttl="24h"

# vault write --output-curl-string can quiclky genrate the curl/api calls required.

#issue using api
curl -X PUT \
-H "X-Vault-Request: true" \
-H "X-Vault-Token: hvs.8Zpy4z7xMOlZVP6i9W72Bzoi" \
-d '{"common_name":"mongo0.example.com","alt_names":"localhost","ttl":"48h"}' \
http://127.0.0.1:8200/v1/pki_int/issue/example-dot-com | jq > mongo.json

# jq pipeline to create combined pem file
<mongo.json jq '.data|.private_key, .certificate, .ca_chain[]' -r > certs/mongo0.example.com.pem


# Ansible community module
# https://docs.ansible.com/ansible/latest/collections/community/hashi_vault/vault_pki_generate_certificate_module.html