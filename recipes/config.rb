#
# Cookbook:: cloudwatch-monitor
# Recipe:: config

# Dependent cookbooks
include_recipe 'cron'

# Set variables
cwmon_home_link = "#{node['cwmon']['base']}/aws-scripts-mon"
options = ['--from-cron'] + node['cwmon']['options']

# Configure cron job
cron_d 'cloudwatch-monitor' do
  minute "*/#{node['cwmon']['interval']}"
  user node['cwmon']['user']
  mailto ''
  path '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
  shell '/bin/bash'
  command %Q(#{cwmon_home_link}/mon-put-instance-data.pl #{(options).join(' ')})
end
