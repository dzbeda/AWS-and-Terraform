## Tags
variable "tags_env" {
  description = "Describe the enviroment"
}
variable "nginx-ami" {
  type = string
}
variable "instance-type" {
  type = string
  default = "t2.micro"
}