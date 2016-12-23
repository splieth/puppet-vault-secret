require 'vault'

module Puppet::Parser::Functions
  newfunction(:read_secret, :type => :rvalue) do |args|
    secret_path = args[0]
    secret_value = args[1]

    raise ArgumentError, 'You need to specify the path to read (e.g. "secret/foo/bar")' if secret_path.nil?
    raise ArgumentError, 'You need to specify value that will be read from the secret' if secret_value.nil?

    Vault.address = ENV['VAULT_ADDR']
    Vault.token = ENV['VAULT_TOKEN']

    begin
      secret = Vault.logical.read(secret_path).data[secret_value.to_sym]
    rescue
      puts 'Error reading from Vault :/'
    end
  end
end
