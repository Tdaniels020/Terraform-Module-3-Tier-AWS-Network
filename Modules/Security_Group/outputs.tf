output "jumpboxSG_id" {
value = aws_security_group.jumpboxSG.id
}

output "WebSG_id" {
value = aws_security_group.WebSG.id
}

output "RDSSG_id" {
value = aws_security_group.RDSSG.id
}

output "AppSG_id" {
value = aws_security_group.AppSG.id
}