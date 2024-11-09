resource "aws_db_subnet_group" "terra_db_subnet_group" {
  name = "terra_db_subnet_group"
  subnet_ids = [
    aws_subnet.terra_private_database_subnet_1.id,
    aws_subnet.terra_private_database_subnet_2.id,
  aws_subnet.terra_private_database_subnet_3.id]

  tags = {
    Name = "terra_db_subnet_group"
  }

}
