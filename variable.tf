variable "region" {
  type    = string
  default = "us-east-2"
}
variable "os" {
    type = string
    default = "Ubuntu" 
    }
variable "launched_by"  {
     type = string
     default = "USER"
      }
variable "ami" {
  type    = string
  default = "ami-020ba0ae8c230ae28"
}
variable "instance_type" { type = string }
variable "application"   { type = string }
variable "environment"   { type = string }
