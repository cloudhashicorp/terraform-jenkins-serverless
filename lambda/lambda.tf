resource "aws_lambda_function" "uglambda" {

  function_name = var.function_name
  role          = var.outuglambdakinesisfirehosefull
  handler       = var.handler
  runtime       = var.runtime
  filename      = var.filename

  environment {
    variables = {

      deliveryStreamName = "serverless-games-stream"
    }
  }
}
