codenamephp_git_client_package 'Install git'

user 'user1' do
  manage_home true
  shell '/bin/bash'
end

user 'user2' do
  manage_home true
  shell '/bin/bash'
end
