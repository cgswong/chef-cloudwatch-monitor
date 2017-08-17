name 'cloudwatch-monitor'
maintainer 'Stuart Wong'
maintainer_email 'cgs.wong@gmail.com'
license 'Apache-2.0'
description 'Install and configure AWS CloudWatch Logs custom metrics for monitoring EC2 instances and sending the data to AWS CloudWatch.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version "1.0.2"

recipe 'cloudwatch-monitor', 'Includes the service recipe by default.'
recipe 'cloudwatch-monitor::install', 'Install AWS CloudWatch custom metrics.'
recipe 'cloudwatch-monitor::config', 'Configures AWS CloudWatch custom metrics.'

source_url 'https://github.com/cgswong/chef-cloudwatch-monitor' if respond_to? :source_url
issues_url 'https://github.com/cgswong/chef-cloudwatch-monitor/issues' if respond_to? :issues_url

%w[amazon ubuntu centos].each do |os|
  supports os
end

depends 'cron', '~> 4.1.3'

chef_version '>= 12.11'
