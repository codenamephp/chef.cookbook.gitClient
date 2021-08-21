require 'spec_helper'

describe 'codenamephp_git_client_config_users' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_git_client_config_users

  context 'Install with minimal properties' do
    recipe do
      codenamephp_git_client_config_users 'Config user' do
        users_configs lazy {
          {
            'user1' => { :config1_user1 => 'value1_user1', 'config2_user1' => 'value2_user1' },
            'user2' => { :config1_user2 => 'value1_user2', 'config2_user2' => 'value2_user2' },
          }
        }
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'calls config resource for both users' do
      expect(chef_run).to set_codenamephp_git_client_config_user('Set configs for user1').with(
        user: 'user1',
        configs: { :config1_user1 => 'value1_user1', 'config2_user1' => 'value2_user1' }
      )
      expect(chef_run).to set_codenamephp_git_client_config_user('Set configs for user2').with(
        user: 'user2',
        configs: { :config1_user2 => 'value1_user2', 'config2_user2' => 'value2_user2' }
      )
    end
  end
end
