resource "aws_glue_catalog_database" "uggluecatalogdb" {

  name = var.nameuggluecatalogdb
}

resource "aws_glue_crawler" "uggluecrawler" {

  database_name = aws_glue_catalog_database.uggluecatalogdb.name
  name          = var.nameuggluecrawler
  role          = var.ugassumegluerole

  s3_target {

    path = "s3://${var.outugs3bucketathena}"
  }
}