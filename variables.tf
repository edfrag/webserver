variable "region" {
  type    = string
  default = "us-east-2"
}

variable "instance_type" {
  type    = string
  default = "t2.small"
}

variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22, 80]
}

variable "subnet-web" {
    type    = string
    default = "subnet-d00ec29d"
}