unified_mode true

property :users_configs, Hash, description: 'Hash of all users and configs with the user as key and the configs as Hash'

action :set do
  new_resource.users_configs.each do |user, configs|
    codenamephp_git_client_config_user "Set configs for #{user}" do
      user user
      configs configs
    end
  end
end
