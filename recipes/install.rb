#
# Cookbook:: cloudwatch-monitor
# Recipe:: install

cwmon_url = "http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-#{node['cwmon']['version']}.zip"
cwmon_home_link = "#{node['cwmon']['base']}/aws-scripts-mon"
cwmon_home = "#{node['cwmon']['base']}/aws-scripts-mon-#{node['cwmon']['version']}"
cwmon_zip = "#{node['cwmon']['base']}/CloudWatchMonitoringScripts-#{node['cwmon']['version']}.zip"

# Install prerequisites
case node['platform_family']
when 'rhel'
  %w[zip unzip perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA].each do |pkg|
    package pkg do
      action :install
    end
  end
when 'amazon'
  %w[zip unzip perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https].each do |pkg|
    package pkg do
      action :install
    end
  end
when 'ubuntu'
  %w[zip unzip libwww-perl libdatetime-perl].each do |pkg|
    package pkg do
      action :install
    end
  end
else
  Chef::Log.warn("#{node['platform_family']} is not supported")
end

# Setup user
group node['cwmon']['group'] do
  action :create
end

user node['cwmon']['user'] do
  comment 'CloudWatch custom metrics user'
  home "/home/#{node['cwmon']['user']}"
  shell '/bin/bash'
  group node['cwmon']['group']
  manage_home true
  action :create
end

# Download, extract and install setup script
directory node['cwmon']['base'] do
  owner 'root'
  group 'root'
  mode '0777'
  recursive true
  action :create
end

remote_file cwmon_zip do
  source cwmon_url
  owner node['cwmon']['user']
  group node['cwmon']['group']
  mode '0644'
  action :create_if_missing
end

script 'extract_aws-scripts-mon' do
  interpreter 'bash'
  user node['cwmon']['user']
  group node['cwmon']['group']
  cwd node['cwmon']['base']
  code <<-EOF
    mkdir -p #{cwmon_home}
    unzip -qqj #{cwmon_zip} -d #{cwmon_home}
    chown -R #{node['cwmon']['user']}:#{node['cwmon']['group']} #{cwmon_home}
    chmod +x #{cwmon_home}/*.pl
  EOF
  not_if { File.directory?(cwmon_home) }
end

link cwmon_home_link do
  to cwmon_home
end

file cwmon_zip do
  action :delete
end
