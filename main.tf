resource "tls_private_key" "intermediate" {
  algorithm   = var.key_algorithm
  ecdsa_curve = var.ecdsa_curve
  rsa_bits    = var.rsa_bits
}

resource "tls_cert_request" "intermediate" {
  key_algorithm   = var.key_algorithm
  private_key_pem = tls_private_key.intermediate.private_key_pem

  subject {
    common_name = var.common_name
  }
}

resource "tls_locally_signed_cert" "intermediate" {
  cert_request_pem   = tls_cert_request.intermediate.cert_request_pem
  ca_key_algorithm   = var.key_algorithm
  ca_private_key_pem = var.root_ca_private_key_pem
  ca_cert_pem        = var.root_ca_certificate_pem

  is_ca_certificate     = true
  validity_period_hours = var.validity_period_hours / 60
  allowed_uses = [
    "cert_signing",
  ]
}