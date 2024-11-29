resource "aws_instance" "web1" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "Production_Env1"
  }
  user_data = <<-EOF
	#!/bin/bash
	sudo yum update -y 
	sudo yum install -y httpd 
	sudo systemctl start httpd 
	sudo systemctl enable httpd 
	echo "<html><body style='background-color:red;'><h1 style='color:white;'>Hello World Prod 1</h1></body></html>" | sudo tee /var/www/html/index.html
	EOF
}

resource "aws_instance" "web2" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "Production_Env2"
  }
  user_data = <<-EOF
	#!/bin/bash
	sudo yum update -y 
	sudo yum install -y httpd 
	sudo systemctl start httpd 
	sudo systemctl enable httpd 
	echo "<html><body style='background-color:blue;'><h1 style='color:white;'>Hello World Prod2</h1></body></html>" | sudo tee /var/www/html/index.html
	EOF
}

resource "aws_instance" "jenkins" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  user_data       = file("scripts/jenkins_install.sh")
  tags = {
    Name = "JenkinsController"
  }
}

resource "aws_instance" "testing" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "Testing_Env"
  }
}

resource "aws_instance" "staging" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "Staging_Env"
  }
}
