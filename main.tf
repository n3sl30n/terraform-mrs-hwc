data "huaweicloud_availability_zones" "mexico2_az" {}

resource "huaweicloud_vpc" "vpc-mrs" {
  name = var.vpc_name
  cidr = var.vpc_cidr
}

resource "huaweicloud_vpc_subnet" "subnet-mrs" {
  name              = var.subnet_name
  cidr              = var.subnet_cidr
  gateway_ip        = var.subnet_gateway_ip
  vpc_id            = huaweicloud_vpc.vpc-mrs.id
  availability_zone = data.huaweicloud_availability_zones.mexico2_az.names[0]
}

resource "huaweicloud_networking_secgroup" "secgroup" {
  name        = var.sg_name
  description = var.sg_description
}

resource "huaweicloud_networking_secgroup_rule" "allow_ssh" {
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "huaweicloud_mapreduce_cluster" "mrs-cluster" {
  availability_zone  = data.huaweicloud_availability_zones.mexico2_az.names[0]
  name               = var.cluster_name
  version            = "MRS 3.1.5"
  type               = "ANALYSIS"
  component_list     = ["Hadoop", "Hive", "Spark2x"]
  manager_admin_pass = var.cluster_password
  node_admin_pass    = var.cluster_password
  vpc_id             = huaweicloud_vpc.vpc-mrs.id
  subnet_id          = huaweicloud_vpc_subnet.subnet-mrs.id

  master_nodes {
    flavor            = "c6.4xlarge.4.linux.bigdata"
    node_number       = 2
    root_volume_type  = "SAS"
    root_volume_size  = 300
    data_volume_type  = "SAS"
    data_volume_size  = 480
    data_volume_count = 1
  }
  analysis_core_nodes {
    flavor            = "c6.4xlarge.4.linux.bigdata"
    node_number       = 3
    root_volume_type  = "SAS"
    root_volume_size  = 300
    data_volume_type  = "SAS"
    data_volume_size  = 480
    data_volume_count = 1
  }
  analysis_task_nodes {
    flavor            = "c6.4xlarge.4.linux.bigdata"
    node_number       = 1
    root_volume_type  = "SAS"
    root_volume_size  = 300
    data_volume_type  = "SAS"
    data_volume_size  = 480
    data_volume_count = 1
  }
}