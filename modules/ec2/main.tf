resource "aws_instance" "ec2-omkar" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = var.subnet_id
    key_name      = var.key_name
    vpc_security_group_ids = [var.vpc_security_group_ids]
    associate_public_ip_address = true

   tags = {
    Name        = "${var.project}-ec2"
    Environment = "${var.environment}"
  }
}


resource "aws_eip" "ec2-omkar-ip" {
    instance = aws_instance.ec2-omkar.id
    vpc = true
    tags = {
        Name        = "${var.project}-ec2-ip"
        Environment = "${var.environment}"
    }
}
