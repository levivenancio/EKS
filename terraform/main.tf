terraform {
  # Provedores Utilizados
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "5.69.0" # Versão do AWS no Terraform
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Criar VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.endereco_vpc

  tags = {
    Name = var.nome_vpc
  }
}

# Criar Subrede Pública
resource "aws_subnet" "Sub_Pub1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.endereco_subrede_publica1_aws
  availability_zone       = "us-east-1a" # Especifique a zona de disponibilidade desejada
  map_public_ip_on_launch = true

  tags = {
    Name = var.nome_subrede_publica1_aws
  }
}

# Criar Subrede Privada
resource "aws_subnet" "Sub_Pub2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.endereco_subrede_publica2_vpc
  availability_zone       = "us-east-1b" # Especifique a zona de disponibilidade desejada
  map_public_ip_on_launch = true

  tags = {
    Name = var.nome_subrede_publica2_vpc
  }
}

# Criar Gateway de Internet 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.nome_gateway
  }
}

# Criar Tabela de Rotas
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.nome_tabela_rotas
  }
}

# Associar as subrede públicas à tabela
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.Sub_Pub1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.Sub_Pub2.id
  route_table_id = aws_route_table.public.id
}


# Criar Grupo de Segurança Linux
resource "aws_security_group" "Grupo_de_Seguranca" {
  name        = var.nome_grupo_seguranca
  description = "Allow SSH, HTTP and alternative HTTP traffic"
  vpc_id      = aws_vpc.vpc.id

  # Regra para permitir SSH na porta 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regra para permitir HTTP na porta 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regra para permitir o ping (ICMP)
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Regras de egress, permitindo todo o tráfego de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Permitir todos os protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }
}
