variable "public_key_path" {
  type = string
}
resource "aws_key_pair" "opsschool" {
  public_key = file(var.public_key_path)
}
