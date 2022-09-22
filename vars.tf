variable "amis" {
  type = map(string)
  default = {
    "us-east-1" = "ami-08c40ec9ead489470"
    "us-east-2" = "ami-097a2df4ac947655f"
  }
}

variable "keys" {
  type = map(string)
  default = {
    "public" = ""
    "secret" = ""
  }
}

variable "cdirs_acesso_remoto" {
  type = list(string)
  default = [
    "131.221.227.10/32"
  ]
}

variable "key_name" {
  type    = string
  default = "terraform_key"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
