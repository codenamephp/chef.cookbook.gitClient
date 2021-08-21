require 'spec_helper'

describe 'codenamephp_git_client_config_users_from_data_bag' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_git_client_config_users_from_data_bag

  before(:example) do
    stub_search('users', 'codenamephp_git_client_config*:*').and_return([])
  end

  context 'Install with minimal properties' do
    before(:example) do
      stub_search('users', 'codenamephp_git_client_config*:*').and_return([
        {
          'id' => 'user1',
          'codenamephp' => {
            'git_client' => {
              'config' => { 'user1_config1' => 'user1_value1', 'user1_config2' => 'user1_value2' },
            },
          },
        },
        {
          'id' => 'user2',
          'codenamephp' => {
            'git_client' => {
              'config' => {},
            },
          },
        },
        {
          'id' => 'user3',
          'codenamephp' => {
            'git_client' => {},
          },
        },
        {
          'id' => 'user4',
          'codenamephp' => {
            'git_client' => {
              'config' => { 'user4_config1' => 'user4_value1', 'user4_config2' => 'user4_value2' },
            },
          },
        },
      ])
    end

    recipe do
      codenamephp_git_client_config_users_from_data_bag 'Manage git users'
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should set configs with mapped users' do
      expect(chef_run).to set_codenamephp_git_client_config_users('Config users from databag').with(
        users_configs: {
          'user1' => { 'user1_config1' => 'user1_value1', 'user1_config2' => 'user1_value2' },
          'user4' => { 'user4_config1' => 'user4_value1', 'user4_config2' => 'user4_value2' },
        }
      )
    end

    it 'does nothing when databag was not found' do
      stub_search('users', 'codenamephp_git_client_config*:*').and_raise(Chef::Exceptions::InvalidDataBagPath)

      expect(chef_run).to_not set_codenamephp_git_client_config_users('Config users from databag')
    end
  end
end
