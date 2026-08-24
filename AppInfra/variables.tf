variable  "aws_region" {
  default     = "eu-west-1"
}
variable "vpc_cidr" {
  type    = string
  default = "11.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["11.0.1.0/24", "11.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["11.0.3.0/24", "11.0.4.0/24"]
}

variable "availability_zone" {
  type    = list(string)
  default = ["eu-west-1a", "eu-west-1b"]
}

variable "public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO4+eHxn1aOaZnu/Lw7SGRBOcG4LZjKyRr0F+tZy4jekb1iVr4/q8Nkb4aA8z4wID7PVrnIJt2HizLdV0H23aBNd92qYk0qK9jNtR0qoUvr1lwwZ9cMZrUHRabNApGjX7jjRh1E9JoYBOZcXnJJ/SXo6UT1VEMGcqoPm8+PKRqNk2njV0Z/jiyEaiNjs7rBCxx5IRKYuAHSwTi2SRGrRjn18Z4ReY+wzidCSyTp43p9GG0S8b9/maIcPU/HB0AnvhqXjTMXbdTmrMJ2x8aBBCXKjc/kmOcx0TUmOgrrM1fpJFmoof1/Wzz7U1HeFRibJo2o+hSDxM3VTGCuKOxKBJL"
}

