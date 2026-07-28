variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "novacommerce"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"
}

variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones for deployment"
  type        = list(string)

  default = [
    "eu-west-2a",
    "eu-west-2b",
    "eu-west-2c"
  ]
}
