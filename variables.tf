variable "runtime" {
  description = "Language to use for Lambda"
  type        = string
  default     = "provided.al2"
}

variable "architecture" {
  description = "Architecture for lambda"
  type        = string
  default     = "arm64"
}

variable "handler" {
  description = "Program entrypoint for Lambda"
  type        = string
  default     = "bootstrap"
}

variable "timeout" {
  description = "Timeout after which Lamdba will terminate"
  type        = string
  default     = "10"
}

variable "source_bucket" {
  description = "Bucket to use for loading Lambda source ZIP"
  type        = string
}

variable "source_prefix" {
  description = "S3 prefix to use for loading Lambda ZIP"
  type        = string
  default     = ""
}

variable "source_version" {
  description = "Version of Lambda ZIP to use"
  type        = string
}

variable "function_name" {
  description = "Name for Lambda function"
  type        = string
}

variable "environment_variables" {
  description = "Variables to provide for Lambda environment"
  type        = map(string)
  default     = {}
}

variable "access_policy_document" {
  description = "IAM policy provided to Lambda role"
  type        = string
}

variable "source_types" {
  description = "Source types which are allowed to invoke the Lambda. Must align with entries in source_arns variable"
  type        = list(string)
  default     = ["apigateway"]
}

variable "source_arns" {
  description = "Source ARNs which are allowed to invoke the Lambda. Must align with entries in source_types variable"
  type        = list(string)
}

variable "cloudwatch_retention_in_days" {
  description = "Days to retain cloudwatch logs"
  type        = number
  default     = 0
}

variable "kms_key_arn" {
  description = "Use custom KMS key for Cloudwatch logs"
  type        = string
  default     = ""
}
