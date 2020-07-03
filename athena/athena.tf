resource "aws_athena_database" "ugathena" {

  name   = var.nameugathena
  bucket = var.outugs3bucketathena
}