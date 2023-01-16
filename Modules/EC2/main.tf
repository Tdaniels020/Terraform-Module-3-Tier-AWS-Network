resource "aws_instance" "jumpboxInstance" {
  ami                         = "ami-09d3b3274b6c5d4aa"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [var.jumpboxSG_id]
  associate_public_ip_address = true
  key_name                    = "finishline-key"
  #user_data                   = "${file("wordpress.sh")}"
  subnet_id = "${var.publicsubnets_cidr}"

  tags = {
    Name = "JumpboxInstance2"
  }
}
  output "jumpboxInstance_ip" {
    value = "${aws_instance.jumpboxInstance.public_ip}"
  }
resource "aws_instance" "WebInstance" {

  ami                         = "ami-09d3b3274b6c5d4aa"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [var.WebSG_id]#[aws_security_group.WebSG_id.id]
  associate_public_ip_address = true
  key_name                    = "finishline-key"
  user_data                   = file("wordpress.sh")
  subnet_id                   = "${var.publicsubnets_cidr}" #["${var.publicsubnets_cidrs[1]}"]
  
  tags = {
    Name = "WebInstance2"
  }

}
output "WebInstance_ip" {
  value = "${aws_instance.WebInstance.public_ip}"
}
resource "aws_instance" "AppInstance" {

  ami                         = "ami-09d3b3274b6c5d4aa"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [var.APPSG_id] #[aws_security_group.APPSG_id.id]
  associate_public_ip_address = false
  key_name                    = "finishline-key"
  #user_data                   = file("wordpress.sh")
  subnet_id = "${var.privatesubnets_cidr}" #["${var.privatesubnets_cidr[0]}"]

  tags = {
    Name = "AppInstance2"
  }

}
output "AppInstance_ip" {
  value = "${aws_instance.AppInstance.private_ip}"
}
resource "aws_instance" "RDSInstance" {
  ami                         = "ami-09d3b3274b6c5d4aa"
  instance_type               = "t2.medium"
  vpc_security_group_ids      =  [var.RDSSG_id] # [aws_security_group.RDSSG_id.id]
  associate_public_ip_address = false
  key_name                    = "finishline-key"
  #user_data                   = "${file("wordpress.sh")}"
  subnet_id = "${var.privatesubnets_cidr}" #["${var.privatesubnets_cidr[1]}"]

  tags = {
    Name = "RDSInstance2"
  }
}
  output "RDSInstance_ip" {
    value = "${aws_instance.RDSInstance.private_ip}"
  }