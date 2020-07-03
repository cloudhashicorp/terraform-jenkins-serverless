resource "aws_kinesis_firehose_delivery_stream" "ugkinesisfirhosstr" {

  name        = "serverless-games-stream"
  destination = "s3"

  s3_configuration {

    role_arn   = var.outugassumefirehoserole
    bucket_arn = var.outugs3bucket
  }
}

