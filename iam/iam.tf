resource "aws_iam_user" "unitygameuser" {

  name          = var.iamusername
  path          = var.iampath
  force_destroy = var.iamforcedestroy
}

resource "aws_iam_access_key" "unitygameaccesskey" {

  user    = aws_iam_user.unitygameuser.name
  pgp_key = var.iampgpkey
}

resource "aws_iam_policy" "unitygameiampolicy" {

  name   = var.ugiampolicyname
  policy = var.iampolicy

}

resource "aws_iam_user_policy_attachment" "ugiampolcyattached" {
  user       = aws_iam_user.unitygameuser.name
  policy_arn = aws_iam_policy.unitygameiampolicy.arn
}

###########################
# Amazon Kinesis Firehose #
########################### 
data "aws_iam_policy" "ugkinesisfirehosefull" {
  arn = var.arni
}

resource "aws_iam_user_policy_attachment" "ugkinfirfulusrattached" {
  user       = aws_iam_user.unitygameuser.name
  policy_arn = data.aws_iam_policy.ugkinesisfirehosefull.arn
}



#Role 
data "aws_iam_policy_document" "ug-trust-assume-role-policy" {
  statement {

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.ugidentifierlambdakinfir
    }

  }
}

resource "aws_iam_role" "uglambdakinesisfirehosefull" {
  name               = var.uglambdakinfirfullaccess
  assume_role_policy = data.aws_iam_policy_document.ug-trust-assume-role-policy.json
}


resource "aws_iam_role_policy_attachment" "kinesisfirehosefullaccess" {

  role       = aws_iam_role.uglambdakinesisfirehosefull.name
  policy_arn = var.policyarnkinfirfulacc
}


resource "aws_iam_role" "ugassumefirehoserole" {

  name               = var.nameugassumefirehoserole
  assume_role_policy = var.iamkinfirhospolicy
}

resource "aws_iam_role" "ugassumegluerole" {

  name               = var.nameuglueserole
  assume_role_policy = var.iamgluepolicy
}