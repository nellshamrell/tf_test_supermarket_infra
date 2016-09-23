chef_server = attribute 'chef_server_hostname', {}
supermarket_server = attribute 'supermarket_server_hostname', {}

describe 'reachable hosts' do
  describe host chef_server do
    it { is_expected.to be_reachable }
  end

  describe host supermarket_server do
    it { is_expected.to be_reachable }
  end
end
