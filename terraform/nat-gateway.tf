resource "aws_eip" "nat" {

  count = length(var.availability_zones)

  domain = "vpc"

}


resource "aws_nat_gateway" "main" {

  count = length(var.availability_zones)


  allocation_id = aws_eip.nat[count.index].id


  subnet_id = aws_subnet.public[count.index].id


  tags = {

    Name = "${var.project_name}-${var.environment}-nat-${count.index + 1}"

  }

}
