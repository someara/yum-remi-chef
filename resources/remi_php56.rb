resource_name :yum_remi_php56
provides :yum_remi_php56
unified_mode true

property :baseurl, String, default: lazy { remi_repo_baseurl('remi-php56') }
property :mirrorlist, String, default: lazy { remi_repo_mirrorlist('remi-php56') }
property :description, String, default: lazy { remi_repo_description('remi-php56') }
property :gpgkey, String, default: lazy { remi_gpg_key }
property :gpgcheck, [true, false], default: true
property :enabled, [true, false], default: true

action :create do
  raise "`remi-php56` is not available for #{node['platform']} #{node['platform_version']}}" if rhel_8_or_fedora?

  yum_remi_safe 'default' unless fedora?

  # use repo on C7
  if rhel_7_or_amazon?
    yum_repository 'remi-php56' do
      baseurl new_resource.baseurl
      mirrorlist new_resource.mirrorlist
      description new_resource.description
      enabled new_resource.enabled
      gpgcheck new_resource.gpgcheck
      gpgkey new_resource.gpgkey
    end
  else
    # use modules on C8 / Fedora
    yum_remi_modular 'default'

    dnf_module 'php:remi-5.6'
  end
end
