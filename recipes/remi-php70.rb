#
# Author:: Sean OMeara (<sean@sean.io>)
# Recipe:: yum-remi-chef::remi-php70
#
# Copyright:: 2015-2019, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

raise "`remi-php70` is not available for #{node['platform']} #{node['platform_version'].to_i}" if rhel_8_or_fedora?

include_recipe 'yum-remi-chef::remi' unless fedora?

%w(remi-php70 remi-php70-debuginfo).each do |repo|
  next unless node['yum'][repo]['managed']
  yum_repository repo do
    node['yum'][repo].each do |config, value|
      case config
      when 'managed' # rubocop: disable Lint/EmptyWhen
      when 'baseurl'
        send(config.to_sym, lazy { value })
      else
        send(config.to_sym, value) unless value.nil?
      end
    end
    gpgkey node['yum-remi-chef']['gpgkey'] unless node['yum-remi-chef']['gpgkey'].nil?
  end
end
