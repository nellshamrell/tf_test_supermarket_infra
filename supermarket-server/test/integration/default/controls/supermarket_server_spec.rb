describe command('lsb_release -a') do
  its('stdout') { should match (/Ubuntu/) }
end

describe command('sudo supermarket-server-ctl') do
  its('stdout') { should match(/supermarket-server-ctl/) }
end
