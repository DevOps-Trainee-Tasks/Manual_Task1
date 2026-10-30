resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main_vpc.id
    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
}

resource "aws_route_table_association" "public_subnets" {
    route_table_id = aws_route_table.route_table.id
    subnet_id = aws_subnet.public_subnets[count.index].id
    count = length(var.public_subnets)

}