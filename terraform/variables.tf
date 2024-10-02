variable "nome_vpc" {
  description = "Descricao da variavel nome_vpc"
  default     = "VPC_Kubernetes"
}
variable "endereco_vpc" {
  description = "Descricao da variavel endereco_vpc"
  default     = "192.168.134.0/24"
  type        = string
}
variable "nome_subrede_publica1_aws" {
  description = "Descricao da variavel nome_subrede_publica1_aws"
  default     = "SubPub1"
}
variable "endereco_subrede_publica1_aws" {
  description = "Descricao da variavel endereco_subrede_publica1_aws"
  default     = "192.168.134.0/25"
  type        = string
}
variable "nome_subrede_publica2_vpc" {
  description = "Descricao da variavel nome_subrede_publica2_vpc"
  default     = "SubPub2"
}
variable "endereco_subrede_publica2_vpc" {
  description = "Descricao da variavel endereco_subrede_publica2_vpc"
  default     = "192.168.134.128/25"
  type        = string
}
variable "nome_gateway" {
  description = "Descricao da variavel nome_gateway"
  default     = "Gateway"
}
variable "nome_tabela_rotas" {
  description = "Descricao da variavel nome_tabela_rotas"
  default     = "Tabela de rotas"
}
variable "nome_grupo_seguranca" {
  description = "Descricao da variavel nome_grupo_seguranca"
  default     = "WEB_SG"
}