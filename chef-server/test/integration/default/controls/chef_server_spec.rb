describe command('lsb_release -a') do
  its('stdout') { should match (/Ubuntu/) }
end

describe file('/var/chef/cache') do
  it { should be_directory }
end
