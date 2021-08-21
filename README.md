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

### config_user
The `codenamephp_git_config_user` is used to configure multiple values for a single user using a hash where the keys are the config keys and values the configs to be set for their keys.
The configs are all set in the --global scope.

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
