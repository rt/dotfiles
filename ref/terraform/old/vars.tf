variable "tenancy_ocid" {}
variable "pod_region" {}
variable "pod_name" {}
variable "pod_cidr" {}
variable "pod_dns_label" {}
variable "pod_custom_dns_servers" {}
variable "pod_search_domain_names" {}
variable "jenkins_cidr" {}
variable "hub_compartment_id" {}

variable "onprem_nets" {
  type        = list(string)
  description = "Network CIDRs to be added to the pod's route table"
  default     = ["10.12.0.0/16", "10.13.0.0/16", "10.14.0.0/16", "10.32.0.0/16", "10.33.0.0/16", "10.34.0.0/16", "10.36.0.0/16", "192.168.88.0/21"]
}

variable "vpn_partners" {
  type        = list(string)
  description = "Network CIDRs for VPN Partners (AMEX)"
  default     = ["148.171.0.0/16", "148.173.0.0/16", "139.71.246.36/32", "139.71.218.185/32"]
}

variable "remote_nets" {
  type        = list(string)
  description = "Remote CIDRs which will be routed via RPC to other OCI regions"
  default     = []
}

variable "oci_nets" {
  type        = list(string)
  description = "Neighboring OCI CIDRs"
  default     = ["10.65.0.0/16", "10.66.0.0/16", "10.67.0.0/16", "10.70.0.0/16"]
}

variable "oci_privnets" {
  type = map(string)
  description = "Subnet CIDRs"
  default = {
    "svc"  = "10.70.11.0/24"
    "ctr"  = "10.70.33.0/24"
    "db"   = "10.70.34.0/24"
    "app"  = "10.70.80.0/24"
  }
}

variable "oci_pubnets" {
  type = map(string)
  description = "Subnet CIDRs"
  default = {
    "pub" = "10.70.32.0/24"
  }
}

