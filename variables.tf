variable "runtime" {
  type    = "string"
  default = "go1.x"
}

variable "handler" {
  type    = "string"
  default = "main"
}

variable "timeout" {
  type    = "string"
  default = "50"
}

variable "lambda-bucket" {
  type = "string"
}

variable "lambda-version" {
  type = "string"
}

variable "function-name" {
  type = "string"
}

variable "environment-variables" {
  type    = "map"
  default = {}
}

variable "access-policy-document" {
  type = "string"
}

variable "trust-policy-document" {
  type = "string"
}

variable "source-type" {
  type    = "list"
  default = ["apigateway"]
}

variable "source-arn" {
  type = "list"
}
