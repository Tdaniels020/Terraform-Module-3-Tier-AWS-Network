resource "tls_private_key" "key" {
  algorithm = "RSA"
}

//resource "local_file" "private_key" {
resource "local_sensitive_file" "private_key" {  
  filename          = "finishline-key.pem"
  content = tls_private_key.key.private_key_pem
  file_permission   = "0400"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "finishline-key"
  public_key = tls_private_key.key.public_key_openssh
}

output "ssh_keypair" {
  value = tls_private_key.key.private_key_pem
}


output "key_name" {
  value = aws_key_pair.key_pair.key_name

}