# Class: vault_secret
#
# This module provides a custom function to read secrets from Vault.
# In this class, you set the URL to your Vault server and define the token
# that is used to read secrets from Vault.
#
# Parameters:
#
# [*url*]  - URL to Vault server to read the secrets from
# [*token*] - Token to access Vault
#
class vault_secret (
  $url = undef,
  $token = undef,
)  {

  if($url == undef or empty($url) or $url == false) {
    validate_string($url)

    exec { 'set-vault-url-in-env':
      environment => ["VAULT_ADDR=${url}"],
    }
  }

  if($token == undef or empty($token) or $token == false) {
    validate_string($token)

    exec { 'set-vault-token-in-env':
      environment => ["VAULT_TOKEN=${token}"],
    }
  }
}
