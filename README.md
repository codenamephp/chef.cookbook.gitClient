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