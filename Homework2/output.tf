output "vpc-id" {
  value = aws_vpc.vpc-main.id
}
output "public-subnet-id" {
  value = aws_subnet.public_subnet.*.id
}
output "private-subnet-id" {
  value = aws_subnet.private_subnet.*.id
}
output "public-security-group-id" {
  value = aws_security_group.ec2-public.id
}
output "nat-elip-id" {
  value = aws_eip.nat-elip.*.id
}
output "nat-gw-id" {
  value = aws_nat_gateway.nat-gw.*.id
}

output "route-table-private-subnet-id" {
  value = aws_route_table.route-table-private-subnet.*.id
}
