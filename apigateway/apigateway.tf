resource "aws_apigatewayv2_api" "ughttpapigateway" {

  name          = var.nameughttpapigateway
  protocol_type = var.protocoltypeughttpapigateway


}


resource "aws_apigatewayv2_integration" "ugapiintegration" {

  api_id             = aws_apigatewayv2_api.ughttpapigateway.id
  integration_type   = var.integrationtypeugapiintegration
  integration_method = var.integrationmethodugapiintegration
  integration_uri    = var.outaws_lambda_function

}


resource "aws_apigatewayv2_route" "ugapiroute" {

  api_id    = aws_apigatewayv2_api.ughttpapigateway.id
  route_key = var.routekeyugapiroute

}


resource "aws_apigatewayv2_stage" "ugapistage" {

  api_id = aws_apigatewayv2_api.ughttpapigateway.id
  name   = var.nameugapistage

}