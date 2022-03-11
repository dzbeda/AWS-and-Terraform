variable "public_key_path" {
  type = string
}
## In order to retrive the public key from private.pem key run ssh-keygen -y -f /path_to_key_pair/my-key-pair.pem
resource "aws_key_pair" "opsschool" {
  public_key = file(var.public_key_path)
}
