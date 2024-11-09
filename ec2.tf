# resource "aws_instance" "instancia" {
#   ami           = "ami-063d43db0594b521b"
#   instance_type = "t2.micro"

#   network_interface {
#     network_interface_id = aws_network_interface.foo.id
#     device_index         = 0
#   }

#   credit_specification {
#     cpu_credits = "freetier"
#   }
resource "aws_instance" "terra_private_ec2_1" {
  ami             = "ami-063d43db0594b521b"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.terra_private_subnet_1.id
  security_groups = [aws_security_group.allow_http.id]

  tags = {
    Name = "terra_private_ec2_1"
  }
}

resource "aws_instance" "terra_private_ec2_2" {
  ami             = "ami-063d43db0594b521b"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.terra_private_subnet_2.id
  security_groups = [aws_security_group.allow_http.id]

  tags = {
    Name = "terra_private_ec2_2"
  }
}

resource "aws_instance" "terra_private_ec2_3" {
  ami             = "ami-063d43db0594b521b"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.terra_private_subnet_3.id
  security_groups = [aws_security_group.allow_http.id]

  tags = {
    Name = "terra_private_ec2_3"
  }
}
