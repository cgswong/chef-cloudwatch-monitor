# AWS CloudWatch Custom Metrics Cookbook

Install and configure [AWS CloudWatch Monitoring Scripts](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html). These are AWS provided Perl scripts for Linux that monitor memory and disk metrics which are pushed to CloudWatch.

## Requirements

### Platforms

- Amazon Linux
- CentOS 7.x/RHEL 7.x
- Ubuntu 14.04, 16.04

### Chef

- Chef 12.11+

### Dependent Cookbooks

- cron

## Attributes

See `attributes/default.rb` for the current default values as the listing below may not be current:

- `node['cwmon']['user']` - The user to run the script and own files. Created if necessary. Defaults to `cwmon`.
- `node['cwmon']['group']` - The user's group. Defaults to `cwmon`.
- `node['cwmon']['base']` - The base directory which will own the installation and files. Defaults to  `/opt/aws/cloudwatch`.
- `node['cwmon']['version']` - The version of the scripts to install. Defaults to `1.2.1`.
- `node['cwmon']['interval']` - Frequency with which to run script via cron job. Defaults to 5 minutes.
- `node['cwmon']['options']` - The list of options to pass to the script. The following options are included by default:
    - `--auto-scaling`
    - `--disk-space-avail`
    - `--disk-space-used`
    - `--disk-space-util`
    - `--disk-path=/`
    - `--mem-avail`
    - `--mem-used`
    - `--mem-used-incl-cache-buff`
    - `--mem-util`
    - `--swap-used`
    - `--swap-util`

**Note**: It is not necessary to include the `--from-cron` option as it is appended to any options specified.

## Usage

Put `recipe[cloudwatch-monitor]` in a run list, or `include_recipe 'cloudwatch-monitor'` to ensure that
the CloudWatch monitoring script is installed and cron'ed on your systems.

## AWS authentication

You instance **must** use an IAM Role for the script to properly work in pushing metrics to CloudWatch. Using IAM instance profiles is a best practice and as such I intentionally did not make provisions for the alternative. An example IAM Profile is:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CustomCloudWatchMetricsAccess",
      "Action": [
        "cloudwatch:PutMetricData",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:ListMetrics",        
        "ec2:DescribeTags"
      ],
      "Effect": "Allow",
      "Resource": [
        "*"
      ]
    }
  ]
}
```

## Changes

See `CHANGELOG.md` for more details.

## License and Author

See `LICENSE` for more details.

## Trademark

Amazon Web Services and AWS are trademarks of Amazon.com, Inc. or its affiliates in the United States and/or other countries.
