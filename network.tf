# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}

resource "aws_vpc" "mustafa_vpc" {
  cidr_block           = "17.1.0.0/25"
  enable_dns_hostnames = true

}

# Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.mustafa_vpc.cidr_block, 4, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.mustafa_vpc.id
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-subnet-${format("%02d", count.index + 1)}"
  }

  depends_on = [aws_vpc.mustafa_vpc]
}