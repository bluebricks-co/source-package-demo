# Terraform AWS EC2 Instance Module (`meitar_instance`)

## 1. Module Overview

This Terraform module provides a comprehensive and highly-configurable way to provision a single AWS EC2 instance. It exposes a wide range of instance parameters, from networking and storage to metadata options and termination protection.

While it can be used to create general-purpose EC2 instances, its default configuration is heavily tailored for creating an **EKS worker node**. The default `user_data`, `iam_instance_profile`, and `tags` are all set to join a specific, pre-existing EKS cluster. For any other use case, you will need to override these default values.

This module simplifies the process of creating a standardized EC2 instance by abstracting the underlying `aws_instance` resource and providing sensible defaults for many common settings.

## 2. Resources Managed

This module creates the following AWS resources:

*   **`aws_instance`**: The primary EC2 instance being provisioned.

## 3. Variables

The module accepts the following variables for customization.

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `capacity_reservation_preference` | `string` | Specifies the Capacity Reservation preference. Can be 'open' or 'none'. | `open` |
| `cpu_core_count` | `number` | The number of CPU cores for the instance. | `1` |
| `cpu_threads_per_core` | `number` | The number of threads per CPU core. | `1` |
| `enclave_enabled` | `bool` | Whether to enable Nitro Enclaves on the instance. | `false` |
| `instance_ami` | `string` | The AMI to use for the instance. | `ami-011bf62e6a9f5a429` |
| `instance_associate_public_ip_address` | `bool` | Whether to associate a public IP address with the instance. | `false` |
| `instance_availability_zone` | `string` | The availability zone to launch the instance in. | `eu-north-1c` |
| `instance_disable_api_stop` | `bool` | If true, enables EC2 Instance Stop Protection. | `false` |
| `instance_disable_api_termination` | `bool` | If true, enables EC2 Instance Termination Protection. | `false` |
| `instance_ebs_optimized` | `bool` | If true, the instance will be EBS-optimized. | `false` |
| `instance_iam_profile` | `string` | The IAM instance profile to associate with the instance. | `eks-80ce02d1-1194-3ed1-4a02-ee2ddd458d41` |
| `instance_initiated_shutdown_behavior` | `string` | Shutdown behavior for the instance. Can be 'stop' or 'terminate'. | `stop` |
| `instance_monitoring` | `bool` | If true, detailed monitoring is enabled on the instance. | `true` |
| `instance_private_ip` | `string` | The primary private IP address to associate with the instance. | `10.4.2.151` |
| `instance_source_dest_check` | `bool` | Controls if traffic is routed to the instance only when the instance is the source or destination of the traffic. | `true` |
| `instance_subnet_id` | `string` | The VPC subnet ID to launch the instance in. | `subnet-0158d1ba95f4bccfd` |
| `instance_tags` | `map(string)` | A map of tags to assign to the instance. | `{"Name": "system", "eks:cluster-name": "bb-eks-gitops", ...}` |
| `instance_type` | `string` | The instance type to use for the instance. | `m7a.medium` |
| `instance_user_data` | `string` | The user data to provide when launching the instance. This is used for EKS node configuration. | `(MIME-multipart content for EKS node bootstrap)` |
| `instance_vpc_security_group_ids` | `list(string)` | A list of security group IDs to associate with. | `["sg-044a4d748968a7545"]` |
| `launch_template_name` | `string` | The name of the launch template. | `eks-80ce02d1-1194-3ed1-4a02-ee2ddd458d41` |
| `launch_template_version` | `string` | The version of the launch template. | `2` |
| `maintenance_auto_recovery` | `string` | The recovery behavior in case of a failure. Can be 'default' or 'disabled'. | `default` |
| `metadata_http_endpoint` | `string` | Enables or disables the IMDSv1 endpoint. Can be 'enabled' or 'disabled'. | `enabled` |
| `metadata_http_protocol_ipv6` | `string` | Enables or disables the IPv6 endpoint for the instance metadata service. Can be 'enabled' or 'disabled'. | `disabled` |
| `metadata_http_put_response_hop_limit` | `number` | The desired HTTP PUT response hop limit for instance metadata requests. | `2` |
| `metadata_http_tokens` | `string` | Specifies if IMDSv2 is required. Can be 'optional' or 'required'. | `required` |
| `metadata_instance_metadata_tags` | `string` | Enables or disables access to instance tags from the instance metadata. Can be 'enabled' or 'disabled'. | `disabled` |
| `private_dns_name_hostname_type` | `string` | The type of hostname for DNS resolution. Can be 'ip-name' or 'resource-name'. | `ip-name` |
| `region` | `string` | AWS region for resources | `eu-north-1` |
| `root_block_device_delete_on_termination` | `bool` | Whether the root block device will be deleted on instance termination. | `true` |
| `root_block_device_encrypted` | `bool` | Whether the root block device should be encrypted. | `false` |
| `root_block_device_iops` | `number` | The amount of provisioned IOPS. This must be set with a volume_type of 'io1', 'io2' or 'gp3'. | `3000` |
| `root_block_device_tags` | `map(string)` | A map of tags to assign to the root block device. | `{"Name": "system", "eks:cluster-name": "bb-eks-gitops", ...}` |
| `root_block_device_throughput` | `number` | The throughput to provision for a 'gp3' volume in MiB/s. | `125` |
| `root_block_device_volume_size` | `number` | The size of the root volume in gigabytes. | `20` |
| `root_block_device_volume_type` | `string` | The type of volume. Can be 'standard', 'gp2', 'gp3', 'io1', 'io2', 'sc1', or 'st1'. | `gp3` |

## 4. Outputs

The module exports the following outputs, which correspond to the attributes of the created `aws_instance`.

| Name | Description |
| --- | --- |
| `ami` | The AMI ID used to launch the EC2 instance. |
| `arn` | The ARN of the EC2 instance. |
| `availability_zone` | The availability zone in which the EC2 instance is running. |
| `host_id` | The ID of the dedicated host the instance is running on, if applicable. |
| `iam_instance_profile` | The IAM instance profile ARN or name attached to the instance. |
| `id` | The ID of the EC2 instance. |
| `instance_state` | The state of the EC2 instance. For example, 'pending', 'running', 'shutting-down', 'terminated', 'stopping', 'stopped'. |
| `instance_type` | The instance type of the EC2 instance. |
| `ipv6_addresses` | A list of IPv6 addresses assigned to the instance's primary network interface. |
| `key_name` | The name of the key pair used to launch the instance. |
| `placement_group` | The name of the placement group the instance is in. |
| `primary_network_interface_id` | The ID of the primary network interface attached to the instance. |
| `private_dns` | The private DNS name assigned to the EC2 instance. |
| `private_ip` | The private IP address assigned to the EC2 instance. |
| `public_dns` | The public DNS name assigned to the EC2 instance, if applicable. |
| `public_ip` | The public IP address assigned to the EC2 instance, if applicable. |
| `subnet_id` | The ID of the subnet in which the EC2 instance is running. |
| `tags_all` | A map of all tags assigned to the instance, including default tags. |
| `tenancy` | The tenancy of the instance (e.g., 'default', 'dedicated'). |
| `vpc_security_group_ids` | A list of security group IDs associated with the EC2 instance. |

## 5. Usage Example

Here is a complete example of how to use this module to create a general-purpose EC2 instance. This example overrides the EKS-specific defaults for broader applicability.

**> Important:** You must replace the placeholder values for `instance_ami`, `instance_subnet_id`, and `instance_vpc_security_group_ids` with values from your own AWS environment.

```terraform
# main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "web_server" {
  source = "./meitar_instance" // Or use a Git source

  # --- General Instance Configuration ---
  region           = "us-east-1"
  instance_type    = "t3.micro"
  instance_ami     = "ami-0c55b159cbfafe1f0" # us-east-1 Amazon Linux 2023 AMI
  instance_tags = {
    Name        = "my-web-server"
    Environment = "dev"
    Project     = "WebApp"
  }

  # --- Networking Configuration ---
  # Replace with your own VPC, Subnet, and Security Group IDs
  instance_subnet_id                 = "subnet-0123456789abcdef0"
  instance_vpc_security_group_ids    = ["sg-fedcba9876543210f"]
  instance_associate_public_ip_address = true # Set to true to access from the internet

  # --- Custom User Data for a simple web server ---
  # This will install and start a simple NGINX web server
  instance_user_data = <<-EOT
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "<h1>Hello from Terraform!</h1>" | sudo tee /usr/share/nginx/html/index.html
  EOT

  # --- Disable EKS-specific defaults ---
  instance_iam_profile    = null # Use null if no IAM profile is needed
  launch_template_name    = null # This module does not require a launch template
  launch_template_version = null
}

# --- Outputs ---

output "web_server_public_ip" {
  description = "The public IP address of the newly created web server."
  value       = module.web_server.public_ip
}

output "web_server_instance_id" {
  description = "The instance ID of the web server."
  value       = module.web_server.id
}
```

## 6. Requirements

| Name | Version |
| --- | --- |
| Terraform | `~> 1.0` |
| AWS Provider | `~> 5.0` |

## 7. Notes and Considerations

*   **EKS-Specific Defaults**: As mentioned, the default values for `instance_user_data`, `instance_tags`, `instance_iam_profile`, and several other variables are highly specific to an EKS environment. You **must** override these for any general-purpose use case, as shown in the usage example above. Failure to do so may result in the instance failing to launch or join an unintended cluster.
*   **Networking**: By default, `instance_associate_public_ip_address` is `false`. The instance will not have a public IP address and will only be accessible from within your VPC. If you need public access, set this variable to `true` and ensure your security groups and VPC route tables are configured correctly.
*   **IAM Profile**: The module requires an IAM profile by default (`instance_iam_profile`). For instances that do not require specific IAM permissions, you can pass `null` to this variable to avoid associating a profile.
*   **Security Groups**: It is critical to provide appropriate `instance_vpc_security_group_ids`. The default value is a placeholder and should be replaced with security groups that adhere to the principle of least privilege.
*   **Launch Templates**: While the variables `launch_template_name` and `launch_template_version` are present (likely from the original EKS use case), this module primarily works by defining the instance directly. For general use, you can set these to `null` if you are not using a launch template.