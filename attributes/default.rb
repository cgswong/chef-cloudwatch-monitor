#
# Cookbook:: cloudwatch-monitor
# Attributes:: default

default['cwmon']['user'] = 'cwmon'
default['cwmon']['group'] = 'cwmon'
default['cwmon']['base'] = '/opt/aws/cloudwatch'
default['cwmon']['version'] = '1.2.1'
default['cwmon']['interval'] = 5
default['cwmon']['options'] = %w[--aggregated
                                 --auto-scaling
                                 --disk-space-avail
                                 --disk-space-used
                                 --disk-space-util
                                 --disk-path=/
                                 --mem-avail
                                 --mem-used
                                 --mem-used-incl-cache-buff
                                 --mem-util
                                 --swap-used
                                 --swap-util]
