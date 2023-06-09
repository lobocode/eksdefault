resource "aws_subnet" "private_subnet" {
  count = 2

  vpc_id = aws_vpc.cluster_vpc.id
  cidr_block = count.index == 0 ? "10.0.32.0/20" : "10.0.48.0/20"
  availability_zone = format("%s%c", var.aws_region, count.index == 0 ? "a" : "c")

  tags = {
    Name = "${var.cluster_name}-private-${var.region_names[count.index]}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}