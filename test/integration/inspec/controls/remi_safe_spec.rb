control 'remi-safe' do
  describe yum.repo('remi-safe') do
    it { should exist }
    it { should be_enabled }
    its('mirrors') do
      should cmp case os.name
                 when 'fedora'
                   "http://cdn.remirepo.net/fedora/#{os.release.to_i}/safe/$basearch/mirror"
                 when 'amazon'
                   'http://cdn.remirepo.net/enterprise/7/safe/mirror'
                 else # rhel
                   if os.release.to_i == 7
                     "http://cdn.remirepo.net/enterprise/#{os.release.to_i}/safe/mirror"
                   else
                     "http://cdn.remirepo.net/enterprise/#{os.release.to_i}/safe/$basearch/mirror"
                   end
                 end
    end
  end

  describe ini('/etc/yum.repos.d/remi-safe.repo') do
    its('remi-safe.gpgcheck') { should cmp 1 }
    its('remi-safe.gpgkey') { should cmp 'https://rpms.remirepo.net/RPM-GPG-KEY-remi' }
  end
end
