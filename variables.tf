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
  description = "[DEPRECATED] Define the certificate common name. Use 'subject' instead"
  type        = string
  default     = ""
}

variable "subject" {
  description = "Subject properties"
  type = object(
    {
      common_name         = string
      organizational_unit = optional(string)
      organization        = optional(string)
      street_address      = optional(list(string))
      postal_code         = optional(string)
      locality            = optional(string)
      province            = optional(string)
      country             = optional(string)
    }
  )

  default = {
    common_name = ""
  }
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
