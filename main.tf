terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server_new" {
  ami           = "ami-04e5276ebb8451442"
  instance_type = "t2.micro"
  user_data     = <<-EOF
              #cloud-config
              package_update: true
              packages:
                  - httpd
              runcmd:
                  - wget -O /var/www/html/index.html https://raw.githubusercontent.com/cloudfaster-academy-workshop/cfa-labs-public-files/main/labs/htmls/primeiro-servidor-web.html
                  - service httpd start
                  - chkconfig httpd on
              EOF

  vpc_security_group_ids = ["sg-0ff74239badc89625"]

  tags = {
    Name = "EC2-WEB-SERVER"


  }
}
