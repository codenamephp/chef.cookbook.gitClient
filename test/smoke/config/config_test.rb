describe command('sudo -u user1 git config --global user.name') do
  its('stdout.strip') { should eq('User1') }
end

describe command('sudo -u user1 git config --global user.email') do
  its('stdout.strip') { should eq('user1@test.de') }
end

describe command('sudo -u user2 git config --global user.name') do
  its('stdout.strip') { should eq('User2') }
end

describe command('sudo -u user2 git config --global user.email') do
  its('stdout.strip') { should eq('user2@test.de') }
end
