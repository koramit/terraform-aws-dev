variable "infra_env" {
  type        = string
  description = "infrastructure environment"
}

variable "default_region" {
  type        = string
  default     = "ap-southeast-1"
  description = "default region"
}

variable "default_azs" {
  type        = list(any)
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  description = "defautl availability zones"
}