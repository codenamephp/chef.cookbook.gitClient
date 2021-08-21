unified_mode true

property :key, String, name_property: true, description: 'The key of config to set, e.g. user.full_name'
property :value, String, description: 'The value to set for the key'
property :user, String, description: 'The user to run the command as'
property :scope, String, equal_to: %w(local global system), default: 'global', description: 'If the value should be set system wide, global for the user or the local repo'
property :path, String, default: '', description: 'The path to exectue the config command in when setting values for a repo'
property :options, String, default: '', description: 'Additional options to add to the command, e.g. --add'

action :set do
  execute config_command do
    cwd new_resource.path
    user new_resource.user
    environment lazy { { 'USER' => new_resource.user, 'HOME' => ::Dir.home(new_resource.user) } }
  end
end

action_class do
  def config_command
    format('git config --%<scope>s %<key>s "%<value>s" %<options>s', scope: new_resource.scope, key: new_resource.key, value: new_resource.value, options: new_resource.options).rstrip
  end
end
