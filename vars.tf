variable "location" {
    type = string
    default = "westus"
}
variable "ssh-source-address" {
    type = string
    default = "*"
}
variable "prefix" {
    type = string
    default = "demo"
}
variable "private-cidr" {
    type = string
    default = "10.0.0.0/24"
}