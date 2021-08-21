
codenamephp_git_client_config_users 'Config user' do
  users_configs lazy {
    {
      'user1' => { 'user.name' => 'User1', 'user.email' => 'user1@test.de' },
      'user2' => { 'user.name' => 'User2', 'user.email' => 'user2@test.de' },
    }
  }
end
