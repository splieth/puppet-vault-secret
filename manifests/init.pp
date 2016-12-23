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
  $url = $vault_secret::params::url,
  $token = $vault_secret::params::token,
) inherits vault_secret::params {

  if($url != undef) {
    validate_string($url)

    exec { 'set-vault-url-in-env':
      environment => ["VAULT_ADDR=${url}"],
    }
  }


  if($token != undef) {
    validate_string($token)

    exec { 'set-vault-token-in-env':
      environment => ["VAULT_TOKEN=${token}"],
    }
  }
}
