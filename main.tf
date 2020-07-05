############################################################
#Author   : Darwin Panela                                  #
#LinkedIn : https://www.linkedin.com/in/darwinpanelacloud/ #
#github   : https://github.com/cloudhashicorp              #
############################################################


#####
#VPC#
#####

module "vpcmod" {
  source = "./vpc"

  name               = "unitygameProj Public Subnet"
  cidr_block         = "10.0.0.0/16"
  azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
  pubsub             = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  routename          = "unitygame Public Route"
  wideopensub        = "0.0.0.0/0"
  nameexternallbmeet = "allow_443"
  descexternallbmeet = "Allow TLS Inbound traffic"

  protocol_ingress    = "tcp"
  sgfrom_port_ingress = 443
  sgto_port_ingress   = 443
  protocol_egress     = "-1"
  sgfrom_port_egress  = 0
  sgto_port_egress    = 0

  naclprotocol_egress  = "tcp"
  naclruleno_egress    = 200
  naclaction_egress    = "allow"
  naclfrom_port_egress = 0
  naclto_port_egress   = 65535

  naclprotocol_ingress  = "tcp"
  naclruleno_ingress    = 100
  naclaction_ingress    = "allow"
  naclfrom_port_ingress = 443
  naclto_port_ingress   = 443




  tagspubsub = {
    Owner       = "AwGoZu"
    Environment = "Production"
    Name        = "Public Subnet"

  }


}

module "iammod" {

  source = "./iam"

  iamusername              = "uguser"
  iampath                  = "/"
  iamforcedestroy          = true
  iampgpkey                = "keybase:test"
  ugiampolicyname          = "allunitygameservices"
  nameugassumefirehoserole = "UGAssumeFirehoseRole"
  nameuglueserole          = "UGAssumeGlueRole"
  uglambdakinfirfullaccess = "1KinesisProducerLambdaRole"
  ugidentifierlambdakinfir = ["lambda.amazonaws.com"]
  policyarnkinfirfulacc    = "arn:aws:iam::aws:policy/AmazonKinesisFirehoseFullAccess"

  iampolicy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF

  iamkinfirhospolicy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  iamgluepolicy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF


}

module "lambdamod" {

  source                         = "./lambda"
  outuglambdakinesisfirehosefull = module.iammod.outuglambdakinesisfirehosefull
  function_name                  = "awgozu_KinesisProducer"
  handler                        = "Kinesis_Lambda.lambda_handler"
  runtime                        = "python3.8"
  filename                       = "./lambda/Kinesis_Lambda.zip"

}

module "apigatewaymod" {

  source                            = "./apigateway"
  outaws_lambda_function            = module.lambdamod.outaws_lambda_function
  nameughttpapigateway              = "serverless-games-analytics"
  protocoltypeughttpapigateway      = "HTTP"
  integrationtypeugapiintegration   = "AWS_PROXY"
  integrationmethodugapiintegration = "POST"
  routekeyugapiroute                = "$default"
  nameugapistage                    = "KinesesProducer"


}

module "s3mod" {

  source = "./s3"

}

module "kinesismod" {

  source                         = "./kinesis"
  outugs3bucket                  = module.s3mod.outugs3bucket
  outuglambdakinesisfirehosefull = module.iammod.outuglambdakinesisfirehosefull
  outugassumefirehoserole        = module.iammod.outugassumefirehoserole
}


module "athenamod" {

  source              = "./athena"
  outugs3bucketathena = module.s3mod.outugs3bucketathena
  nameugathena        = "ug_athena"
}

module "gluemod" {

  source              = "./glue"
  outugathena         = module.athenamod.outugathena
  outugs3bucketathena = module.s3mod.outugs3bucketathena
  ugassumegluerole    = module.iammod.ugassumegluerole
  nameuggluecatalogdb = "ugcatalogdbcraw"
  nameuggluecrawler   = "ugcrawler"


}

terraform {
  backend "s3" {
    bucket     = "15ugterrabucket"
    region     = "us-east-1"
    key        = "terraform.tfstate"
    access_key = "AKIA6EGNWL7QK4GCJ7V5"
    secret_key = "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"
  }
}






