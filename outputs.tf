output "certificate_bundle_pem" {
  description = "A bundle containing the private key and the resulting certificate."
  value       = "${tls_private_key.intermediate.private_key_pem}${tls_locally_signed_cert.intermediate.cert_pem}"
}

output "private_key_pem" {
  description = "The private key of the certificate."
  value       = tls_private_key.intermediate.private_key_pem
}

output "certificate_pem" {
  description = "The resulting certificate."
  value       = tls_locally_signed_cert.intermediate.cert_pem
}