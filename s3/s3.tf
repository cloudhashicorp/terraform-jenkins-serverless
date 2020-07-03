resource "aws_s3_bucket" "ugs3bucket" {

  bucket = "serverless-games-q7460"
  acl    = "private"
}