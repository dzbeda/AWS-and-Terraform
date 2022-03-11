# TODO , is elastic ip should be part of vpc  ? Is it a public IP - If so , each instance on public subnet is getting public IP so what is the diffrence ?
## Elastic IP
resource "aws_eip" "nat-elip" {
  count = 2
 depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat-gw" {
  count = 2
  allocation_id = aws_eip.nat-elip.*.id[count.index]
  subnet_id     = aws_subnet.public_subnet.*.id[count.index]
  tags = {
    Name = "nat-gw-${count.index + 1}"
    env = var.tags_env
  }
  depends_on = [aws_internet_gateway.gw]
}
