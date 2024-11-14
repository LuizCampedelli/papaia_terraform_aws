resource "aws_rds_cluster" "db_terra_app" {
  cluster_identifier        = "terra"
  availability_zones        = ["us-east-1a", "us-east-1b", "us-east-1c"]
  engine                    = "mysql"
  db_cluster_instance_class = "db.r6gd.xlarge"
  storage_type              = "io1"
  allocated_storage         = 100
  iops                      = 3000
  master_username           = "root"
  master_password           = random_password.password.result
  db_subnet_group_name      = aws_db_subnet_group.terra_db_subnet_group.name
  vpc_security_group_ids    = [aws_security_group.rds_sg.id]

  tags = {
    Name = "terra_db_mysql"
  }
}
