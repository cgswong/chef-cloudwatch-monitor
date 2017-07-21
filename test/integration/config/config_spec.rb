# # encoding: utf-8

# Inspec test for recipe cloudwatch-monitor::config

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Test for directories
describe file('/opt/aws/cloudwatch/aws-scripts-mon') do
  it { should be_symlink }
end

describe file('/etc/cron.d/cloudwatch-monitor') do
  it { should exist }
end

