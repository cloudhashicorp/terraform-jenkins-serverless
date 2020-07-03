
resource "aws_vpc" "vpcunitygame" {

  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igwunitygame" {

  vpc_id = aws_vpc.vpcunitygame.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_subnet" "unitygamepubsub" {

  count             = length(var.pubsub)
  vpc_id            = aws_vpc.vpcunitygame.id
  cidr_block        = var.pubsub[count.index]
  availability_zone = var.azs[count.index]

  #check needs to be done in this line for tagging
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tagspubsub,
  )
}

resource "aws_route_table" "unitygameroute" {

  vpc_id = aws_vpc.vpcunitygame.id

  tags = {

    Name = var.routename
  }
}


resource "aws_route_table_association" "unitygamepubsubassoc" {

  count = length(var.pubsub)

  subnet_id      = element(aws_subnet.unitygamepubsub.*.id, count.index)
  route_table_id = aws_route_table.unitygameroute.id

}


resource "aws_route" "igwunitygamepubrt" {

  gateway_id             = aws_internet_gateway.igwunitygame.id
  route_table_id         = aws_route_table.unitygameroute.id
  destination_cidr_block = var.wideopensub

}

resource "aws_security_group" "externallbmeet" {

  name        = var.nameexternallbmeet
  description = var.descexternallbmeet
  vpc_id      = aws_vpc.vpcunitygame.id


  ingress {

    from_port   = var.sgfrom_port_ingress
    to_port     = var.sgto_port_ingress
    protocol    = var.protocol_ingress
    cidr_blocks = [var.cidr_block]

  }

  egress {
    from_port   = var.sgfrom_port_egress
    to_port     = var.sgto_port_egress
    protocol    = var.protocol_egress
    cidr_blocks = [var.cidr_block]
  }

}

resource "aws_network_acl" "unitygamenacl" {

  vpc_id = aws_vpc.vpcunitygame.id

  egress {

    protocol   = var.naclprotocol_egress
    rule_no    = var.naclruleno_egress
    action     = var.naclaction_egress
    cidr_block = var.cidr_block
    from_port  = var.naclfrom_port_egress
    to_port    = var.naclto_port_egress

  }

  ingress {

    protocol   = var.naclprotocol_ingress
    rule_no    = var.naclruleno_ingress
    action     = var.naclaction_ingress
    cidr_block = var.cidr_block
    from_port  = var.naclfrom_port_ingress
    to_port    = var.naclto_port_ingress

  }

}




