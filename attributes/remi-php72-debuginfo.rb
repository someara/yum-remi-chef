default['yum']['remi-php72-debuginfo']['repositoryid'] = 'remi-php72-debuginfo'
default['yum']['remi-php72-debuginfo']['gpgcheck'] = true
default['yum']['remi-php72-debuginfo']['enabled'] = false
default['yum']['remi-php72-debuginfo']['managed'] = false

case node['platform']
when 'fedora'
  default['yum']['remi-php72-debuginfo']['baseurl'] = "http://cdn.remirepo.net/fedora/#{node['platform_version'].to_i}/debug-php72/$basearch/"
  default['yum']['remi-php72-debuginfo']['description'] = "Remi's PHP 7.2 RPM repository for Fedora Linux #{node['platform_version'].to_i} - $basearch - debuginfo"
when 'amazon'
  # Default to EL7
  default['yum']['remi-php72-debuginfo']['baseurl'] = 'http://cdn.remirepo.net/enterprise/7/debug-php72/$basearch/'
  default['yum']['remi-php72-debuginfo']['description'] = "Remi's PHP 7.2 RPM repository for Enterprise Linux 7 - $basearch - debuginfo"
else
  default['yum']['remi-php72-debuginfo']['baseurl'] = "http://cdn.remirepo.net/enterprise/#{node['platform_version'].to_i}/debug-php72/$basearch/"
  default['yum']['remi-php72-debuginfo']['description'] = "Remi's PHP 7.2 RPM repository for Enterprise Linux #{node['platform_version'].to_i} - $basearch - debuginfo"
end
