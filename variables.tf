variable "region" {
  type        = string
  description = "Default AWS Region"
  default     = "us-east-1"
}

variable "tags" {
  type = map(string)
  description = "Tags to aws resources"
  default = {
    "Name" = "Created by terraform."
  }
}