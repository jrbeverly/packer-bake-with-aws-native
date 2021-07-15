variable "key" {
  type        = string
  description = "Unique key for this deployment"
}

variable "compute_type" {
  type        = string
  description = "Compute type"
  default     = "BUILD_GENERAL1_SMALL"
}

variable "image" {
  type        = string
  description = "Image"
  default     = "aws/codebuild/standard:5.0"
}

variable "vpc_id" {
  type        = string
  description = "Image"
}

variable "subnet_id" {
  type        = list(string)
  description = "Image"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups"
}

variable "buildspec" {
  type        = string
  description = "BuildSpec"
}

variable "source_bucket" {
  type        = string
  description = "Source bucket"
}

variable "source_objectkey" {
  type        = string
  description = "Source objectkey"
}