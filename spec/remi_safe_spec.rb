require 'spec_helper'
require 'shared_examples'

describe 'yum-remi-chef::remi-safe' do
  default_attributes['yum']['remi-safe-debuginfo']['enabled'] = true
  default_attributes['yum']['remi-safe-debuginfo']['managed'] = true

  context 'on Amazon Linux 2' do
    platform 'amazon', '2'

    include_examples 'create remi-safe repo'
  end

  %w(7 8).each do |version|
    context "on CentOS #{version}" do
      platform 'centos', version

      include_examples 'create remi-safe repo'
    end
  end

  context 'on Debian' do
    platform 'debian'

    it do
      expect { chef_run }.to_not raise_error
    end
  end
end
