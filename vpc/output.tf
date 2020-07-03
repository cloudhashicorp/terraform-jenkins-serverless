output "outunitygamevpc" {

  description = "ID of the VPC created"
  value       = aws_vpc.vpcunitygame.id
}

output "outunitygamepubsub" {

  description = "ID of each Public subnet"
  value       = aws_subnet.unitygamepubsub.*.id


}



