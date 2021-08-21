unified_mode true

property :user, String, description: 'The user to set the configs for'
property :configs, Hash, description: 'Hash of config_key => config_value entries that will be set'

action :set do
  new_resource.configs.each do |config_name, config_value|
    codenamephp_git_client_config "Setting config #{config_name.to_s} for #{new_resource.user}" do
      key config_name.to_s
      value config_value.to_s
      scope 'global'
      user new_resource.user
    end
  end
end
