variable "iamusername" {

  type = string

}

variable "iampath" {

  type = string
}

variable "iamforcedestroy" {

  type = string
}


variable "iampgpkey" {

  type = string
}

variable "ugiampolicyname" {

  type = string
}

variable "iampolicy" {

  type = string
}

variable "iamkinfirhospolicy" {

  type = string
}

variable "arni" {

  type    = string
  default = "arn:aws:iam::aws:policy/AmazonKinesisFirehoseFullAccess"
}


variable "uglambdakinfirfullaccess" {

  type = string
}

variable "ugidentifierlambdakinfir" {

  type = list(string)
}

variable "policyarnkinfirfulacc" {

  type = string
}

variable "nameugassumefirehoserole" {

  type = string
}

variable "nameuglueserole" {

  type = string
}

variable "iamgluepolicy" {

  type = string
}
