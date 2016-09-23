describe file('/etc/opscode/chef-server.rb') do
  it { should be_file }
  its('content') { should match(/oc_id/) }
  its('content') { should match(/applications/) }
  its('content') { should match(/supermarket/) }
end
