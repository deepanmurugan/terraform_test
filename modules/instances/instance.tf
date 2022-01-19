#AMI Filter for Windows Server 2019 Base
data "aws_ami" "ubuntu" {
     most_recent = true
     filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
 }
     filter {
       name   = "virtualization-type"
       values = ["hvm"]
 }
     owners = ["099720109477"]
 }

resource "aws_instance" "eks-bastion" {
  ami                         = data.aws_ami.ubuntu.id 
  count                       = 1 
  instance_type               = var.instance_type
  subnet_id                   = element(var.public_subnet_id, count.index)
  key_name                    = aws_key_pair.aws_key.id
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
  user_data = file("${path.module}/configure_bastion.sh")
  tags = merge(
    var.default_tags,
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-Instance-${count.index}"
    },
  )
}

resource "aws_key_pair" "aws_key" {
  key_name   = "newkey"
  public_key = var.public_key
  tags = merge(
    var.default_tags,
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-KeyPair}"
    },
  )
}

resource "aws_security_group" "bastion_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}