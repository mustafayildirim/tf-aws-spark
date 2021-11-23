data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "web" {
  count         = var.az_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.nano"
  subnet_id     = aws_subnet.public[count.index].id

  root_block_device {
    volume_size = 8
  }

  user_data = <<-EOF
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo "$(hostname -f)" | sudo tee /var/www/html/index.html
  EOF

}
