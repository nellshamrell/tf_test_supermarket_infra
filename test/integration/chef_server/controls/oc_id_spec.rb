describe file('/etc/opscode/chef-server.rb') do
  it { should be_file }
  its('content') { should match(/oc_id/) }
  its('content') { should match(/applications/) }
  its('content') { should match(/supermarket/) }
end

describe file('/etc/opscode/oc-id-applications/supermarket.json') do
  it { should be_file }
  its('content') { should match(/supermarket/) }
  its('content') { should match(/uid/) }
  its('content') { should match(/secret/) }
end
