/*output "oic_instance" {
  value       = oci_integration_integration_instance.oic_instance
  description = "The created OIC instance"
  sensitive   = true
}

output "data" {
  value = jsondecode(data.local_file.idcs_token.content)["access_token"]
  description = "value"
}
*/