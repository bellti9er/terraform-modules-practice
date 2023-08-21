variable "name"             { default = "" } 
variable "cidr_block"       {              } 
variable "public_subnets"   {
  type = list(object({
    cidr_block = string
    zone       = string
    tags       = map(any)
  }))
  default = []
}
