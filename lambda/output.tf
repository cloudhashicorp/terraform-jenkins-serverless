output "outaws_lambda_function" {

  value = aws_lambda_function.uglambda.invoke_arn
}