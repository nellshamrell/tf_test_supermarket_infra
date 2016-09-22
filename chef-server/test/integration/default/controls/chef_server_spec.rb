describe command('lsb_release -a') do
  its('stdout') { should match (/Ubuntu/) }
end

describe file('/var/chef/cache') do
  it { should be_directory }
end

describe file('/var/chef') do
  it { should be_owned_by 'ubuntu' }
end

describe command('ls /var/chef/cookbooks') do
  its('stdout') { should match (/apt-chef/) }
  its('stdout') { should match (/apt/) }
  its('stdout') { should match (/chef-ingredient/) }
  its('stdout') { should match (/chef-server/) }
  its('stdout') { should match (/packagecloud/) }
  its('stdout') { should match (/yum-chef/) }
  its('stdout') { should match (/yum/) }
end

describe file('/tmp/dna.json') do
  it { should be_file }
  its('content') { should match(/chef-server/) }
  its('content') { should match(/api_fqdn/) }
end

describe command('sudo chef-server-ctl') do
  its('stdout') { should match(/chef-server-ctl/) }
  its('stdout') { should match(/Backup the Chef Server/) }
end

describe file('/etc/chef') do
  it { should be_directory }
end

describe file('/tmp/bootstrap-chef-server.sh') do
  it { should be_file }
  it { should be_executable.by_user('ubuntu') }
  its('content') { should match(/sudo chef-server-ctl user-create/) }
  its('content') { should match(/sudo chef-server-ctl org-create/) }
  its('content') { should match(/administrators/) }
  its('content') { should match(/sudo chef-server-ctl reconfigure/) }
end
