provider "aws" {
  region = "us-east-1"
  access_key = var.keys["public"]
  secret_key = var.keys["secret"]
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
  access_key = var.keys["public"]
  secret_key = var.keys["secret"]
}

resource "aws_instance" "dev" {
  count         = 3
  ami           = var.amis["us-east-1"]
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "dev${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

# resource "aws_instance" "dev4" {
#   ami           = var.amis["us-east-1"]
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   tags = {
#     Name = "dev4"
#   }
#   vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
#   depends_on = [
#     aws_s3_bucket.dev4
#   ]
# }

resource "aws_instance" "dev5" {
  ami           = var.amis["us-east-1"]
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "dev5"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_instance" "dev6" {
  provider      = aws.us-east-2
  ami           = var.amis["us-east-2"]
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "dev6"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
  depends_on = [
    aws_dynamodb_table.dynamodb-homologacao
  ]
}

resource "aws_instance" "dev7" {
  provider      = aws.us-east-2
  ami           = var.amis["us-east-2"]
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "dev7"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
}

resource "aws_s3_bucket" "homologacao" {
  bucket = "rafael-homologacao"

  tags = {
    Name = "rafael-homologacao"
  }
}

resource "aws_s3_bucket_acl" "s3-acl" {
  bucket = aws_s3_bucket.homologacao.id
  acl    = "private"
}

resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider     = aws.us-east-2
  name         = "GameScores"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}
