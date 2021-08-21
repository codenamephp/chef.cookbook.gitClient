require 'spec_helper'

describe 'codenamephp_git_client_config_user' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_git_client_config_user

  context 'Install with minimal properties' do
    recipe do
      codenamephp_git_client_config_user 'Config user' do
        user 'some user'
        configs lazy { { :config1 => 'value1', 'config2' => 'value2' } }
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'Will install git from package' do
      expect(chef_run).to set_codenamephp_git_client_config('Setting config config1 for some user').with(
        key: 'config1',
        value: 'value1',
        scope: 'global',
        user: 'some user'
      )
      expect(chef_run).to set_codenamephp_git_client_config('Setting config config2 for some user').with(
        key: 'config2',
        value: 'value2',
        scope: 'global',
        user: 'some user'
      )
    end
  end
end
