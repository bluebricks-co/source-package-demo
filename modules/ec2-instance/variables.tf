variable "region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-north-1"
}

variable "instance_ami" {
  type        = string
  description = "The AMI to use for the instance."
  default     = "ami-011bf62e6a9f5a429"
}

variable "instance_associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public IP address with the instance."
  default     = false
}

variable "instance_availability_zone" {
  type        = string
  description = "The availability zone to launch the instance in."
  default     = "eu-north-1c"
}

variable "instance_disable_api_stop" {
  type        = bool
  description = "If true, enables EC2 Instance Stop Protection."
  default     = false
}

variable "instance_disable_api_termination" {
  type        = bool
  description = "If true, enables EC2 Instance Termination Protection."
  default     = false
}

variable "instance_ebs_optimized" {
  type        = bool
  description = "If true, the instance will be EBS-optimized."
  default     = false
}

variable "instance_iam_profile" {
  type        = string
  description = "The IAM instance profile to associate with the instance."
  default     = "eks-80ce02d1-1194-3ed1-4a02-ee2ddd458d41"
}

variable "instance_initiated_shutdown_behavior" {
  type        = string
  description = "Shutdown behavior for the instance. Can be 'stop' or 'terminate'."
  default     = "stop"
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the instance."
  default     = "m7a.medium"
}

variable "instance_monitoring" {
  type        = bool
  description = "If true, detailed monitoring is enabled on the instance."
  default     = true
}

variable "instance_private_ip" {
  type        = string
  description = "The primary private IP address to associate with the instance."
  default     = "10.4.2.151"
}

variable "instance_source_dest_check" {
  type        = bool
  description = "Controls if traffic is routed to the instance only when the instance is the source or destination of the traffic."
  default     = true
}

variable "instance_subnet_id" {
  type        = string
  description = "The VPC subnet ID to launch the instance in."
  default     = "subnet-0158d1ba95f4bccfd"
}

variable "instance_tags" {
  type        = map(string)
  description = "A map of tags to assign to the instance."
  default = {
    "Name"                                    = "system"
    "eks:cluster-name"                        = "bb-eks-gitops"
    "eks:nodegroup-name"                      = "default"
    "k8s.io/cluster-autoscaler/bb-eks-gitops" = "owned"
    "k8s.io/cluster-autoscaler/enabled"       = "true"
    "kubernetes.io/cluster/bb-eks-gitops"     = "owned"
  }
}

variable "instance_user_data" {
  type        = string
  description = "The user data to provide when launching the instance. This is used for EKS node configuration."
  default     = "MIME-Version: 1.0\nContent-Type: multipart/mixed; boundary=\"//\"\n\n--//\nContent-Type: application/node.eks.aws\n\n---\napiVersion: node.eks.aws/v1alpha1\nkind: NodeConfig\nspec:\n  cluster:\n    apiServerEndpoint: https://C080494B575C8B184F9EC25E14EF9126.gr7.eu-north-1.eks.amazonaws.com\n    certificateAuthority: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJTU5pN1ZlUTQ2NUF3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBMU1ERXdOelEyTXpSYUZ3MHpOREEwTWprd056VXhNelJhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURMejE0WXpMcTBHYno2OGVoM1l5bDdIamNYdWpKRXltSGtwcTFrUTNIL1M2SE8vZWFqa2NUL09UY24Kc28wQ09rTERSK2oyRy9lU2wzekl4aTVIVGgrU2t1S0xDQ1FwT2FwMXlraUV1TG9vNFlDbmk2MkxiM1lBbFk1RwpWRHJuVDkyZTF1Wjh0dkNscWxXbHdRN3BlQytkRkdkSTdEUFV1UVZSaGZWVXdIM1hDNVR1TWhVR0ZCdGVSUTBKClBVZ2lmSzUzd1luakxiMGMwaFdQSWR0Z3VpWm05dUYveldzdGRvNFVEaWw2czN1RG5WYmFIZGI0Y2hOOTUxNjkKWVJDZUpPS01nSVEzS0t5SXc5L0drNVhyR0htcllBLzNYeWxlbE0yb1lUYjRLWFAyaVBRWkZ0K2xHY3ZVRVZOeQovYVV1TktjNVAvb1J4MmM0NWxDSW5jTEZmeENyQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJScVU2dkNXOStNL1dRbHNaWlkxNnBXRFJJOHdUQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQkEwa0lwREZoagpnVUdGNzdFczkwWVVoamc1VElrRHVZd0ZwR2VabXRyME1wRk9pREZwVzMwb0ZrVXVSekdQTGJld0pzNVd6T2s2CitwcHZkS1JqbmIxcXFMU2VmdDVxVGowbmliakJSRno4SDVWTVdFd2JwVkFmRlkzcnBqRG9jYkJnTmQ4TWt3VVMKOTVLRlh4YnZGcmRjY2hMMFArblRubnlFUzBMdlo3NTFVTlpoQ0EvUGZXUE50OHZGTHZ3VXBaT3Y4VzBGeFArYQpDbWhObzFFYzlxRjh0Wkg5ZE1oUVk5Tk5LSkFQOWxPdHR4ZDRONGEwdzY2VWQ2TVRxL2w2bnBmU1ZkbjN5Z1V6CjRJSUxMQU10dWJETkdOaXA5ajlXeXFxeVd3ZC9OOHVraElwaDdYRFRlb3B3RlJMaEd5SFdMazZuNlVOTEhzQXMKQjllVzdQa2I4RlM0Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K\n    cidr: 172.20.0.0/16\n    name: bb-eks-gitops\n  kubelet:\n    config:\n      maxPods: 98\n      clusterDNS:\n      - 172.20.0.10\n    flags:\n    - \"--node-labels=eks.amazonaws.com/nodegroup-image=ami-011bf62e6a9f5a429,eks.amazonaws.com/sourceLaunchTemplateVersion=1,eks.amazonaws.com/capacityType=ON_DEMAND,eks.amazonaws.com/nodegroup=default,eks.amazonaws.com/sourceLaunchTemplateId=lt-02cdfe144fef38cdc\"\n\n--//--"
}

variable "instance_vpc_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to associate with."
  default     = ["sg-044a4d748968a7545"]
}

variable "capacity_reservation_preference" {
  type        = string
  description = "Specifies the Capacity Reservation preference. Can be 'open' or 'none'."
  default     = "open"
}

variable "cpu_core_count" {
  type        = number
  description = "The number of CPU cores for the instance."
  default     = 1
}

variable "cpu_threads_per_core" {
  type        = number
  description = "The number of threads per CPU core."
  default     = 1
}

variable "enclave_enabled" {
  type        = bool
  description = "Whether to enable Nitro Enclaves on the instance."
  default     = false
}

variable "launch_template_name" {
  type        = string
  description = "The name of the launch template."
  default     = "eks-80ce02d1-1194-3ed1-4a02-ee2ddd458d41"
}

variable "launch_template_version" {
  type        = string
  description = "The version of the launch template."
  default     = "2"
}

variable "maintenance_auto_recovery" {
  type        = string
  description = "The recovery behavior in case of a failure. Can be 'default' or 'disabled'."
  default     = "default"
}

variable "metadata_http_endpoint" {
  type        = string
  description = "Enables or disables the IMDSv1 endpoint. Can be 'enabled' or 'disabled'."
  default     = "enabled"
}

variable "metadata_http_protocol_ipv6" {
  type        = string
  description = "Enables or disables the IPv6 endpoint for the instance metadata service. Can be 'enabled' or 'disabled'."
  default     = "disabled"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  description = "The desired HTTP PUT response hop limit for instance metadata requests."
  default     = 2
}

variable "metadata_http_tokens" {
  type        = string
  description = "Specifies if IMDSv2 is required. Can be 'optional' or 'required'."
  default     = "required"
}

variable "metadata_instance_metadata_tags" {
  type        = string
  description = "Enables or disables access to instance tags from the instance metadata. Can be 'enabled' or 'disabled'."
  default     = "disabled"
}

variable "private_dns_name_hostname_type" {
  type        = string
  description = "The type of hostname for DNS resolution. Can be 'ip-name' or 'resource-name'."
  default     = "ip-name"
}

variable "root_block_device_delete_on_termination" {
  type        = bool
  description = "Whether the root block device will be deleted on instance termination."
  default     = true
}

variable "root_block_device_encrypted" {
  type        = bool
  description = "Whether the root block device should be encrypted."
  default     = false
}

variable "root_block_device_iops" {
  type        = number
  description = "The amount of provisioned IOPS. This must be set with a volume_type of 'io1', 'io2' or 'gp3'."
  default     = 3000
}

variable "root_block_device_throughput" {
  type        = number
  description = "The throughput to provision for a 'gp3' volume in MiB/s."
  default     = 125
}

variable "root_block_device_volume_size" {
  type        = number
  description = "The size of the root volume in gigabytes."
  default     = 20
}

variable "root_block_device_volume_type" {
  type        = string
  description = "The type of volume. Can be 'standard', 'gp2', 'gp3', 'io1', 'io2', 'sc1', or 'st1'."
  default     = "gp3"
}

variable "root_block_device_tags" {
  type        = map(string)
  description = "A map of tags to assign to the root block device."
  default = {
    "Name"               = "system"
    "eks:cluster-name"   = "bb-eks-gitops"
    "eks:nodegroup-name" = "default"
  }
}