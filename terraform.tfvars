region              = "us-east-1"
project_name        = "finishline-vpc"
vpc_cidr            =  "192.168.0.0/16" #"10.0.0.0/16"
public_AZ           = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_AZ          = ["us-east-1d", "us-east-1e"]
privatesubnets_cidr = ["192.168.0.0/24", "192.168.1.0/24"]#["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
publicsubnets_cidr  = ["192.168.2.0/24", "192.168.3.0/24"] #["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
#security_group_id   = ["aws_security_group.WebSG.id", "aws_security_group.jumpboxSG.id", "aws_security_group.RDSSG.id", "aws_security_group.AppSG.id"]
