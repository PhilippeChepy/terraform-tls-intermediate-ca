output "certificate_bundle_pem" {
  value = "${tls_private_key.intermediate.private_key_pem}${tls_locally_signed_cert.intermediate.cert_pem}"
}

output "private_key_pem" {
  value = tls_private_key.intermediate.private_key_pem
}

output "certificate_pem" {
  value = tls_locally_signed_cert.intermediate.cert_pem
}