require 'spec_helper'

describe 'vault_secret' do

  context 'with undef params' do

    let(:params) do
      {
          url: nil,
          token: nil,
      }
    end

    it 'does not set env' do
      should_not contain_exec('set-vault-url-in-env')
      should_not contain_exec('set-vault-token-in-env')
    end

  end

  context 'handling env' do

    let(:params) do
      {
          url: 'https://some-url.tld',
          token: 'some-token',
      }
    end

    it 'sets vault url in environment' do
      should_not contain_exec('set-vault-url-in-env')
                     .with_environment('VAULT_ADDR=https://some-url.tld')
    end

    it 'sets vault token in environment' do
      should_not contain_exec('set-vault-token-in-env')
                     .with_environment('VAULT_TOKEN=some-token')
    end
  end
end
