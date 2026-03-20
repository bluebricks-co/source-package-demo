# outputs.tf

output "id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.instance.id
}

output "arn" {
  description = "The ARN of the EC2 instance."
  value       = aws_instance.instance.arn
}

output "instance_state" {
  description = "The state of the EC2 instance. For example, 'pending', 'running', 'shutting-down', 'terminated', 'stopping', 'stopped'."
  value       = aws_instance.instance.instance_state
}

output "ami" {
  description = "The AMI ID used to launch the EC2 instance."
  value       = aws_instance.instance.ami
}

output "instance_type" {
  description = "The instance type of the EC2 instance."
  value       = aws_instance.instance.instance_type
}

output "availability_zone" {
  description = "The availability zone in which the EC2 instance is running."
  value       = aws_instance.instance.availability_zone
}

output "public_ip" {
  description = "The public IP address assigned to the EC2 instance, if applicable."
  value       = aws_instance.instance.public_ip
}

output "public_dns" {
  description = "The public DNS name assigned to the EC2 instance, if applicable."
  value       = aws_instance.instance.public_dns
}

output "private_ip" {
  description = "The private IP address assigned to the EC2 instance."
  value       = aws_instance.instance.private_ip
}

output "private_dns" {
  description = "The private DNS name assigned to the EC2 instance."
  value       = aws_instance.instance.private_dns
}

output "ipv6_addresses" {
  description = "A list of IPv6 addresses assigned to the instance's primary network interface."
  value       = aws_instance.instance.ipv6_addresses
}

output "subnet_id" {
  description = "The ID of the subnet in which the EC2 instance is running."
  value       = aws_instance.instance.subnet_id
}

output "vpc_security_group_ids" {
  description = "A list of security group IDs associated with the EC2 instance."
  value       = aws_instance.instance.vpc_security_group_ids
}

output "primary_network_interface_id" {
  description = "The ID of the primary network interface attached to the instance."
  value       = aws_instance.instance.primary_network_interface_id
}

output "iam_instance_profile" {
  description = "The IAM instance profile ARN or name attached to the instance."
  value       = aws_instance.instance.iam_instance_profile
}

output "key_name" {
  description = "The name of the key pair used to launch the instance."
  value       = aws_instance.instance.key_name
}

output "placement_group" {
  description = "The name of the placement group the instance is in."
  value       = aws_instance.instance.placement_group
}

output "tenancy" {
  description = "The tenancy of the instance (e.g., 'default', 'dedicated')."
  value       = aws_instance.instance.tenancy
}

output "host_id" {
  description = "The ID of the dedicated host the instance is running on, if applicable."
  value       = aws_instance.instance.host_id
}

output "tags_all" {
  description = "A map of all tags assigned to the instance, including default tags."
  value       = aws_instance.instance.tags_all
}