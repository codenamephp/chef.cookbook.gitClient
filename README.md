# Chef Cookbook
[![CI](https://github.com/codenamephp/chef.cookbook.gitClient/actions/workflows/ci.yml/badge.svg)](https://github.com/codenamephp/chef.cookbook.gitClient/actions/workflows/ci.yml)

## Usage

Just include this cookbook in a wrapper cookbook and use the resources as you see fit. Just make sure you install git before you use any of the resources that use it
since they assume it is installed. You can of course use the `codenamephp_git_client_package` resource for this.

## Resources
### package
The `codenamephp_git_client_package` resource installs the package using a package manager.

#### Actions
- `:install`: Installs the git client using a package manager.

#### Properties
- `package_name`: The name of the package to install, defaults to `'git'`

#### Examples
```ruby
# Minimal properties
codenamephp_git_client_package 'Install git'

# With custom package name
codenamephp_git_client_package 'Install git' do
  package_name 'some package'
end
```

### config
The `codenamephp_git_client_config` resource is used to set configurations through `git config`. It supports system wide, user global and per-repo configurations.

#### Actions
- `set`: Sets the given config

#### Properties
- `key`: The key of config to set, e.g. user.full_name, defaults to the resource name
- `value`: The config value to set
- `user`: The user to run the command as
- `scope`: The scope to set the config for, one of `local global system`, defaults to global
- `path`: The path to run the command in, needed when setting per-repo settings, defaults to empty string
- `options`: Additional options that will be appended to the command, defaults to empty string

#### Exmaples
```ruby
# Minimal properties
codenamephp_git_client_config 'user.full_name' do
  value 'Some User'
  user 'someuser'
end

# All properties
codenamephp_git_client_config 'Set some config' do
  key 'some config'
  value 'some value'
  user 'someuser'
  scope 'local'
  path '/some/path'
  options '--some-options'
end
```

### config_user
The `codenamephp_git_client_config_user` is used to configure multiple values for a single user using a hash where the keys are the config keys and values the configs to be set for their keys.
The configs are all set in the --global scope.
Uses `codenamephp_git_client_config` internally.

#### Actions
- `:set`: Sets the given configs for the given user

#### Properties
- `user`: The user to execute the command as and to set the configs for
- `configs`: A hash with the config keys and their values

#### Examples
```ruby
# Minimal properties
codenamephp_git_client_config_user 'Set configs for user' do
  user 'some user'
  configs lazy { { 'user.full_name' => 'Test User', 'user.email' => 'test@test.de' } }
end
```

### config_users
The `codenamephp_git_client_config_users` is used to configure multiple configs for multiple users at once. The configs are passed as a Hash with the username as key and another Hash with config name => config value pairs.
Uses `codenamephp_git_client_config_user` internally.

#### Actions
- `:set`: Sets the given configs for the given users

#### Properties
- `users_configs`: A Hash with the username as key and another Hash with config name => config value pairs.

#### Examples
```ruby
# Minimal properties
codenamephp_git_client_config_users 'Config user' do
  users_configs lazy {
    {
      'user1' => { :config1_user1 => 'value1_user1', 'config2_user1' => 'value2_user1' },
      'user2' => { :config1_user2 => 'value1_user2', 'config2_user2' => 'value2_user2' },
    }
  }
end
```

### config_users_from_data_bag
The `config_users_from_data_bag` resource can be used to set git configurations from data bags. The configs have to be set in the user item. Example:

```json
{
  "id": "user",
  "codenamephp": {
    "git_client": {
      "config": {
        "user.full_name": "Test User",
        "user.email": "test@test.de"
      }
    }
  }
}
```

Only users that have a non-empty config set are used.

#### Actions
- `manage`: Manages the configs from the data bag

#### Properties
- `data_bag_name`: The name of the data bag to search for users, defaults to `users`

#### Examples

```ruby
# Minimal properties
codenamephp_git_client_config_users_from_data_bag 'Manage git users'

# With custom data_bag_name
codenamephp_git_client_config_users_from_data_bag 'Manage git users' do
  data_bag_name 'some_data_bag'
end
```