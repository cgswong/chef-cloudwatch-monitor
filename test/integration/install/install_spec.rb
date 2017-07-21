# # encoding: utf-8

# Inspec test for recipe cloudwatch-monitor::install

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Test for directories
describe file('/opt/aws/cloudwatch') do
  it { should be_directory }
end

describe file('/opt/aws/cloudwatch/aws-scripts-mon') do
  it { should be_symlink }
end

describe file('/opt/aws/cloudwatch/aws-scripts-mon/mon-put-instance-data.pl') do
  it { should be_exist }
end

describe user('cwmon') do
  it { should exist }
end


describe package('unzip') do
  it { should be_installed }
end

describe package('unzip') do
  it { should be_installed }
end

if os[:family] == 'rhel'
  describe package('perl-Switch') do
    it { should be_installed }
  end
  describe package('perl-DateTime') do
    it { should be_installed }
  end
  describe package('perl-Sys-Syslog') do
    it { should be_installed }
  end
  describe package('perl-LWP-Protocol-https') do
    it { should be_installed }
  end
  describe package('perl-Digest-SHA') do
    it { should be_installed }
  end
elsif os[:family] == 'amazon'
  describe package('perl-Switch') do
    it { should be_installed }
  end
  describe package('perl-DateTime') do
    it { should be_installed }
  end
  describe package('perl-Sys-Syslog') do
    it { should be_installed }
  end
  describe package('perl-LWP-Protocol-https') do
    it { should be_installed }
  end
elsif os[:family] == 'debian'
  describe package('libwww-perl') do
    it { should be_installed }
  end
  describe package('libdatetime-perl') do
    it { should be_installed }
  end
end

