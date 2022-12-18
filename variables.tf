variable "cloud_id" {
  default = "b1g54521qm46mkhhpbmr"
}
variable "folder_id" {
  default = "b1g1l3j3k0909cn94se2"
}
variable "sa0_id" {
  default     = "ajeems469fk1okblbl3s"
  description = "ID основного созданного вручную сервисного аккаунта"
}

variable "token" {
  default     = "y0_AgAAAABmyZvjAATuwQAAAADV_2bBnUhicQSjSrG877uhNHXMMpO45eU"
  description = ""
}
variable "zone" {
  description = "Use specific availability zone"
  type        = string
  default     = "ru-central1-a"
}