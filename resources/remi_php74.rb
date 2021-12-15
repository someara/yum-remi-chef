resource_name :yum_remi_php74
provides :yum_remi_php74
unified_mode true

property :baseurl, String, default: lazy { remi_repo_baseurl('php74') }
property :mirrorlist, String, default: lazy { remi_repo_mirrorlist('php74') }
property :description, String, default: lazy { remi_repo_description('php74') }
property :gpgkey, String, default: lazy { remi_gpg_key }
property :gpgcheck, [true, false], default: true
property :enabled, [true, false], default: true

property :debug_baseurl, String, default: lazy { remi_repo_baseurl('debug-php74') }
property :debug_description, String, default: lazy { remi_repo_description('debug-php74') }
property :debug_enabled, [true, false], default: false

action :create do
  raise "`remi-php74` is not available for #{node['platform']} #{node['platform_version'].to_i}" if fedora?

  yum_remi 'default'

  # use repo on C7
  if rhel_7_or_amazon?
    yum_repository 'remi-php74' do
      baseurl new_resource.baseurl
      mirrorlist new_resource.mirrorlist
      description new_resource.description
      enabled new_resource.enabled
      gpgcheck new_resource.gpgcheck
      gpgkey new_resource.gpgkey
      # amazon base repo has priority 10, need to override to get the correct php version
      priority '9' if amazon?
    end

    yum_repository 'remi-php74-debuginfo' do
      baseurl new_resource.debug_baseurl
      description new_resource.debug_description
      enabled new_resource.debug_enabled
      gpgcheck new_resource.gpgcheck
      gpgkey new_resource.gpgkey
    end
  else
    # use modules on C8 / Fedora
    yum_remi_modular 'default'

    dnf_module 'php:remi-7.4'
  end
end
