
variable "vpc-cidr" {
 type         = string
 description  = "name of vpc-cidr"
 default      = "10.0.0.0/16"
}

 variable "prod-pub-sub1" {
   type        = string
   description = "prod-pub-subnet1-cidr"
   default     = "10.0.1.0/24"
}

 variable "prod-pub-sub2" {
   type        = string
   description = "prod-pub-subnet2-cidr"
   default     = "10.0.2.0/24"
   
   }


 variable "prod-pub-sub3" {
   type        = string
   description = "prod-pub-subnet3-cidr"
   default     = "10.0.3.0/24"
}



variable "prod-priv-sub1" {
  type         = string
  description  = "prod-priv-sub1-cidr"
  default      = "10.0.4.0/24"
  }
  

variable "prod-priv-sub2" {
  type         = string
  description  = "prod-priv-sub2-cidr"
  default      = "10.0.5.0/24"
  }










