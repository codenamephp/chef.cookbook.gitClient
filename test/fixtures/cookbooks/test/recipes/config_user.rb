codenamephp_git_client_config_user 'Config user1' do
  user 'user1'
  configs lazy { { 'user.name' => 'User1', 'user.email' => 'user1@test.de' } }
end

codenamephp_git_client_config_user 'Config user2' do
  user 'user2'
  configs lazy { { 'user.name' => 'User2', 'user.email' => 'user2@test.de' } }
end
