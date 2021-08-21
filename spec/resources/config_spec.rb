require 'spec_helper'

describe 'codenamephp_git_client_config' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_git_client_config

  before(:example) do
    allow(Dir).to receive(:home).with('someuser').and_return('/home/someuser')
  end

  context 'Install with minimal properties' do
    recipe do
      codenamephp_git_client_config 'user.full_name' do
        value 'Some User'
        user 'someuser'
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'sets the config' do
      expect(chef_run).to run_execute('git config --global user.full_name "Some User"').with(
        cwd: '',
        user: 'someuser',
        environment: { 'USER' => 'someuser', 'HOME' => '/home/someuser' }
      )
    end
  end

  context 'Install with all properties' do
    recipe do
      codenamephp_git_client_config 'Set some config' do
        key 'some config'
        value 'some value'
        user 'someuser'
        scope 'local'
        path '/some/path'
        options '--some-options'
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'sets the config' do
      expect(chef_run).to run_execute('git config --local some config "some value" --some-options').with(
        cwd: '/some/path',
        user: 'someuser',
        environment: { 'USER' => 'someuser', 'HOME' => '/home/someuser' }
      )
    end
  end
end
