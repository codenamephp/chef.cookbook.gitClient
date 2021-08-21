require 'spec_helper'

describe 'codenamephp_git_client_package' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_git_client_package

  context 'Install with minimal properties' do
    recipe do
      codenamephp_git_client_package 'Install git'
    end

    it 'Will install git from package' do
      expect(chef_run).to install_package('git')
    end
  end

  context 'With custom package name' do
    recipe do
      codenamephp_git_client_package 'Install git' do
        package_name 'some package'
      end
    end

    it 'Will install the custom package' do
      expect(chef_run).to install_package('some package')
    end
  end
end
