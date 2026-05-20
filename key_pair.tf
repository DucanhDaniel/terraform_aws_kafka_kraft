resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "pem-key" {
  key_name   = "terraform-aws-kafka"
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename        = "${path.module}/terraform-aws-kafka.pem"
  content         = tls_private_key.pk.private_key_pem
  file_permission = "0400"
}
