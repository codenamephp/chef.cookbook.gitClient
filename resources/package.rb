unified_mode true

property :package_name, String, default: 'git', description: 'The name of the package to install'

action :install do
  package new_resource.package_name
end
