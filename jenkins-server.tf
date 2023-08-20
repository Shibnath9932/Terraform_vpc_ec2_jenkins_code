data "aws_ami" "latest-ubuntu-image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]  # Canonical's AWS account ID
}

resource "aws_instance" "myapp-server" {
  ami                         = data.aws_ami.latest-ubuntu-image.id
  instance_type               = var.instance_type
  key_name                    = "shibnath_jenkins-server"
  subnet_id                   = aws_subnet.shibnath-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.shibnath_default-sg.id]
  availability_zone           = var.avail_zone
  associate_public_ip_address = true
  user_data                   = file("./jenkins-server-script.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}
