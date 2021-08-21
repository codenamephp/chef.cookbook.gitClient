unified_mode true

property :data_bag_name, String, default: 'users', description: 'The databag to query for the users to manage'

action :manage do
  begin
    users_configs = search(new_resource.data_bag_name, 'codenamephp_git_client_config*:*')
                    .to_h { |user| [user[:id], user.dig(:codenamephp, :git_client, :config) || {}] }
                    .select { |_, configs| !configs.nil? && !configs.empty? }

    codenamephp_git_client_config_users 'Config users from databag' do
      users_configs users_configs
    end
  rescue Net::HTTPServerException, Chef::Exceptions::InvalidDataBagPath
    log "Databag '#{new_resource.data_bag_name}' with query 'codenamephp_git_client_config:*' was not found" do
      level :debug
    end
  end
end
