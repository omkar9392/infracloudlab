provider "aws" {
    region = "ap-south-1"
    profile = "terraform"
}


resource "aws_security_group" "WPTFSG" {
    name = "WPTFSG"

    ingress{
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    }

    ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow http"
    from_port = 0
    to_port = 80
    protocol = "tcp"
    }

    egress{
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "permit all"
    from_port = 0
    to_port = 0
    protocol = "-1"
    }
}

resource "aws_instance" "wordpressfrontend" {
    ami = "ami-010aff33ed5991201"
    instance_type = "t2.micro"
    key_name = "TFkey"
    security_groups = [ "WPTFSG" ]
    tags = {
        app = "wordpress"
        role = "frontend"
        name = "Omkar WebServer"
    }
}


resource "aws_eip" "wordpress-ip" {
    instance = aws_instance.wordpressfrontend.id
    vpc = true
    tags = {
        app = "wordpress"
        name = " omkar elasticip"
    }
}

resource "aws_db_instance" "wordpressbackend" {
    instance_class = "db.t3.micro"
    engine = "mysql"
    publicly_accessible = false
    allocated_storage = 20
    db_name = "wordpress"
    username = "admin"
    password = var.dbpassword
    skip_final_snapshot = true
    tags = {
        app = "mysql"
    }
}

resource "null_resource" "configweb12" {
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("/home/omkar/.ssh/id_rsa")
        host = aws_instance.wordpressfrontend.public_ip
    }
    provisioner "remote-exec" {
        inline = [
            "sudo yum install httpd -y",
            "sudo systemctl start httpd",
            "sudo systemctl enable httpd",
            "sudo wget https://wordpress.org/wordpress-5.7.2.tar.gz",
            "sudo tar -xzf wordpress-5.7.2.tar.gz",
            "sudo cp -r wordpress/* /var/www/html/"
        ]
    }
}

resource "null_resource" "configphp" {
    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("/home/omkar/.ssh/id_rsa")
        host = aws_instance.wordpressfrontend.public_ip
    }
    provisioner "remote-exec" {
        inline = [
            "sudo yum install -y amazon-linux-extras",
            "sudo amazon-linux-extras enable php7.2",
            "sudo yum clean metadata -y",
            "sudo yum install php-cli php-pdo php-fpm php-json php-mysqlnd -y",
            "sudo systemctl restart httpd"
        ]
    }
}
