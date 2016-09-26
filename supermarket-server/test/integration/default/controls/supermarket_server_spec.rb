describe command('lsb_release -a') do
  its('stdout') { should match (/Ubuntu/) }
end

describe command('sudo supermarket-ctl') do
  its('stdout') { should match(/Enter the rails console for Supermarket/) }
end
