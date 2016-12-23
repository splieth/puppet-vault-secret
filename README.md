# Vault-Secret Puppet Module

[![Puppet
Forge](http://img.shields.io/puppetforge/v/counterliero/vault_secret.svg)](https://forge.puppetlabs.com/counterliero/vault_secret)
[![Build Status](https://travis-ci.org/counterliero/puppet-vault-secret.svg?branch=master)](https://travis-ci.org/counterliero/puppet-vault-secret)

This module provides a custom Puppet function that allows you to read secrets from [Hashicorp Vault](https://vaultproject.io).

## Usage

Initially, you need to ensure that the environment variables `VAULT_ADDR` and `VAULT_TOKEN` are set since the [vault-ruby](https://github.com/hashicorp/vault-ruby) (which is utilized here) Gem utilizes these to communicate with the Vault server.

You can do this via the this module (see Parameters for details):

```puppet
class { 'vault_secret':
	url   => 'https://some-vault.com:443',
	token => 'abc-123-555-666',
}
```

If you don't use the module for doing this, the custom function will still rely on the environment variables to be set. So beware to set them ;)

Afterwards, you will be able to read a secret.

```puppet
$secret = read_secret('secret/some-secret', 'some-key')
```

This will return the secret stored in the path `secret/some-secret` and return the value for `some-key`.

## Parameters

 - `url` - URL to Vault server to read the secrets from.
 - `token` - Token to access Vault.

These parameters can also be defined using hiera:

```yaml
vault_secret::url: 'https://some-vault'
vault_secret::token: '123-456-789'
```

The custom function takes two parameters which are mandatory:

 - `path` - The path from which the secret will be read.
 - `key` - Since the lookup of `path` will return a Hash, you need to specify the key whichs's value will be read.


## Requirements

This module has the following requirements:

 - Puppet: Version > 3.0 and < 5.0
 - Operating System: RHEL 7 or CentOS 7

## Dependencies

None.

## Installation

In order to install the module, you can utilize [librarian-puppet](https://github.com/rodjek/librarian-puppet) in order to get it as a dependency. Simple add the following line to your `Puppetfile`:

```ruby
mod 'counterliero/vault_secret', '>= 0.0.1'
```

## Links

- [Hashicorp Vault](https://www.vaultproject.io)
- [vault-ruby](https://github.com/hashicorp/vault-ruby)

## License

This project is licensed under the [Apache 2 License](https://www.apache.org/licenses/LICENSE-2.0).
