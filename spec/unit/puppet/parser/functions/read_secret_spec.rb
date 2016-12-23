require 'spec_helper'

describe Puppet::Parser::Functions.function(:read_secret) do

  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it 'should exist' do
    expect(Puppet::Parser::Functions.function('read_secret')).to eq 'function_read_secret'
  end

  context 'wrong arguments' do

    it 'fails when less than two arguments are passed' do
      expect { scope.function_read_secret(['some-parameter']) }.to raise_error(/Wrong number/)
    end
  end

  context 'environment' do

    it 'failes when VAULT_ADDR are missing' do
      ENV['VAULT_ADDR'] = nil

      expect { scope.function_read_secret(['some/path', 'some-key']) }.to raise_error(/VAULT_ADDR/)
    end

    it 'failes when VAULT_TOKEN are missing' do
      ENV['VAULT_TOKEN'] = nil

      expect { scope.function_read_secret(['some/path', 'some-key' ]) }.to raise_error(/VAULT_TOKEN/)
    end
  end
end
