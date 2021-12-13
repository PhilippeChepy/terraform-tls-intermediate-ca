variable "key_algorithm" {
  description = "Key Algorithm (e.g. 'RSA' or 'ECDSA'), with 'RSA' as the default."
  type        = string
  default     = "RSA"
}

variable "ecdsa_curve" {
  description = "May be any of 'P224', 'P256', 'P384' or 'P521', with 'P224' as the default."
  type        = string
  default     = null
}

variable "rsa_bits" {
  description = "Defaults to '4096' bits."
  type        = string
  default     = 4096
}

variable "common_name" {
  description = "Define the certificate common name."
  type        = string
}

variable "validity_period_hours" {
  description = "The certificate will expire after this amount of time."
  type        = number
}

variable "root_ca_private_key_pem" {
  description = "The private key used to sign this certificate."
  type        = string
}

variable "root_ca_certificate_pem" {
  description = "The root or intermediate certificate used to sign this certificate."
  type        = string
}
