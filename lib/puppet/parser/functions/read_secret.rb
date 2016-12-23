require 'vault'

module Puppet::Parser::Functions
  newfunction(:read_secret, :type => :rvalue) do |args|
    secret_path = args[0]
    secret_value = args[1]

    raise ArgumentError, 'Wrong number of arguments' if args.size != 2

    raise 'VAULT_ADDR not set' unless ENV['VAULT_ADDR']
    raise 'VAULT_TOKEN not set' unless ENV['VAULT_TOKEN']

    Vault.address = ENV['VAULT_ADDR']
    Vault.token = ENV['VAULT_TOKEN']

    begin
      secret = Vault.logical.read(secret_path).data[secret_value.to_sym]
    rescue
      puts 'Error reading from Vault :/'
    end
  end
end
