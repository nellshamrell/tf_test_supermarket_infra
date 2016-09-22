describe command('lsb_release -a') do
  its('stdout') { should match (/Ubuntu/) }
end

describe file('/var/chef/cache') do
  it { should be_directory }
end

describe file('/var/chef') do
  it { should be_owned_by 'ubuntu' }
end

describe command('ls ~/cookbooks') do
  its('stdout') { should match (/apt-chef/) }
  its('stdout') { should match (/apt/) }
  its('stdout') { should match (/chef-ingredient/) }
  its('stdout') { should match (/chef-server/) }
  its('stdout') { should match (/packagecloud/) }
  its('stdout') { should match (/yum-chef/) }
  its('stdout') { should match (/yum/) }
end
