terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "rafael-terraform-alura"

    workspaces {
      name = "aws-terraform-alura"
    }
  }
}