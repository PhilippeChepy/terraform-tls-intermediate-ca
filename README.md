# Terraform PKI: Intermediate Certificate Authority

This module allows one to build a TLS Intermediate Certificate Authority and its associated private key.

Part of this collection:
- https://github.com/PhilippeChepy/terraform-tls-root-ca
- https://github.com/PhilippeChepy/terraform-tls-intermediate-ca
- https://github.com/PhilippeChepy/terraform-tls-certificate

## Example usage

With a root CA certificate generated by the [Root CA module](https://github.com/PhilippeChepy/terraform-tls-root-ca):

```terraform
module "ca_certificate" {
  source = "git@github.com:PhilippeChepy/terraform-tls-root-ca.git"

  common_name           = "Root CA"
  validity_period_hours = 87660
}

module "vault_ica_certificate" {
  source = "git@github.com:PhilippeChepy/terraform-tls-intermediate-ca.git"

  common_name             = "Vault ICA"
  validity_period_hours   = 87660
  root_ca_private_key_pem = module.ca_certificate.private_key_pem
  root_ca_certificate_pem = module.ca_certificate.certificate_pem
}

module "vault_server_certificate" {
  source   = "git@github.com:PhilippeChepy/terraform-tls-certificate.git"
  for_each = module.vault_cluster.instances

  signing_key_pem  = module.vault_ica_certificate.private_key_pem
  signing_cert_pem = module.vault_ica_certificate.certificate_pem

  common_name = each.value.hostname
  dns_sans    = [each.value.hostname]
  ip_sans = concat(
    length(each.value.ipv4_address) != 0 ? [each.value.ipv4_address] : [],
    length(each.value.ipv6_address) != 0 ? [each.value.ipv6_address] : [],
  )

  server_auth = true
  client_auth = false

  validity_period_hours = 87660
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

The following providers are used by this module:

- <a name="provider_tls"></a> [tls](#provider\_tls)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [tls_cert_request.intermediate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) (resource)
- [tls_locally_signed_cert.intermediate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) (resource)
- [tls_private_key.intermediate](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_common_name"></a> [common\_name](#input\_common\_name)

Description: Define the certificate common name.

Type: `string`

### <a name="input_root_ca_certificate_pem"></a> [root\_ca\_certificate\_pem](#input\_root\_ca\_certificate\_pem)

Description: The root or intermediate certificate used to sign this certificate.

Type: `string`

### <a name="input_root_ca_private_key_pem"></a> [root\_ca\_private\_key\_pem](#input\_root\_ca\_private\_key\_pem)

Description: The private key used to sign this certificate.

Type: `string`

### <a name="input_validity_period_hours"></a> [validity\_period\_hours](#input\_validity\_period\_hours)

Description: The certificate will expire after this amount of time.

Type: `number`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_ecdsa_curve"></a> [ecdsa\_curve](#input\_ecdsa\_curve)

Description: May be any of 'P224', 'P256', 'P384' or 'P521', with 'P224' as the default.

Type: `string`

Default: `null`

### <a name="input_key_algorithm"></a> [key\_algorithm](#input\_key\_algorithm)

Description: Key Algorithm (e.g. 'RSA' or 'ECDSA'), with 'RSA' as the default.

Type: `string`

Default: `"RSA"`

### <a name="input_rsa_bits"></a> [rsa\_bits](#input\_rsa\_bits)

Description: Defaults to '4096' bits.

Type: `string`

Default: `4096`

## Outputs

The following outputs are exported:

### <a name="output_certificate_bundle_pem"></a> [certificate\_bundle\_pem](#output\_certificate\_bundle\_pem)

Description: A bundle containing the private key and the resulting certificate.

### <a name="output_certificate_pem"></a> [certificate\_pem](#output\_certificate\_pem)

Description: The resulting certificate.

### <a name="output_private_key_pem"></a> [private\_key\_pem](#output\_private\_key\_pem)

Description: The private key of the certificate.
<!-- END_TF_DOCS -->