output "outugs3bucket" {

  value = aws_s3_bucket.ugs3bucket.arn
}

output "outugs3bucketathena" {

  value = aws_s3_bucket.ugs3bucket.bucket
}