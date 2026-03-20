# __generated__ by Bluebricks Cloud-to-Code Agent
# This configuration was automatically generated from your cloud infrastructure.
#
# For more information, visit: https://bluebricks.co/docs


resource "aws_instance" "instance" {
  ami                                  = var.instance_ami
  availability_zone                    = var.instance_availability_zone
  disable_api_stop                     = var.instance_disable_api_stop
  disable_api_termination              = var.instance_disable_api_termination
  ebs_optimized                        = var.instance_ebs_optimized
  enable_primary_ipv6                  = null
  force_destroy                        = false
  get_password_data                    = false
  hibernation                          = false
  host_id                              = ""
  host_resource_group_arn              = null
  iam_instance_profile                 = var.instance_iam_profile
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  instance_type                        = var.instance_type
  key_name                             = ""
  monitoring                           = var.instance_monitoring
  placement_partition_number           = 0
  region                               = var.region
  tags                                 = var.instance_tags
  tags_all                             = var.instance_tags
  tenancy                              = "default"
  user_data                            = var.instance_user_data
  user_data_base64                     = null
  user_data_replace_on_change          = null
  volume_tags                          = null
  capacity_reservation_specification {
    capacity_reservation_preference = var.capacity_reservation_preference
  }
  cpu_options {
    core_count       = var.cpu_core_count
    threads_per_core = var.cpu_threads_per_core
  }
  enclave_options {
    enabled = var.enclave_enabled
  }
  launch_template {
    name    = var.launch_template_name
    version = var.launch_template_version
  }
  maintenance_options {
    auto_recovery = var.maintenance_auto_recovery
  }
  metadata_options {
    http_endpoint               = var.metadata_http_endpoint
    http_protocol_ipv6          = var.metadata_http_protocol_ipv6
    http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
    http_tokens                 = var.metadata_http_tokens
    instance_metadata_tags      = var.metadata_instance_metadata_tags
  }
  primary_network_interface {
    network_interface_id = "eni-0b8511c64d2190a33"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = false
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = var.private_dns_name_hostname_type
  }
  root_block_device {
    delete_on_termination = var.root_block_device_delete_on_termination
    encrypted             = var.root_block_device_encrypted
    iops                  = var.root_block_device_iops
    kms_key_id            = ""
    tags                  = var.root_block_device_tags
    tags_all              = var.root_block_device_tags
    throughput            = var.root_block_device_throughput
    volume_size           = var.root_block_device_volume_size
    volume_type           = var.root_block_device_volume_type
  }
}