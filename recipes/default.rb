#
# Cookbook:: cloudwatch-monitor
# Recipe:: default

if node['ec2'].nil?
  log('Refusing to install CloudWatch Logs because this does not appear to be an EC2 instance.') { level :warn }
  return
end

# Install only if it is not installed
include_recipe 'cloudwatch-monitor::install' unless File.directory?("#{node['cwmon']['base']}/aws-scripts-mon-#{node['cwmon']['version']}")
# Always reconfigure AWS CloudWatch Logs configuration files
include_recipe 'cloudwatch-monitor::config'
