resource "oci_integration_integration_instance" "oic_instance" {
  compartment_id            = var.oic_definition.compartment
  display_name              = var.oic_definition.name
  integration_instance_type = var.oic_definition.instance_type
  is_byol                   = var.oic_definition.is_byol
  message_packs             = var.oic_definition.message_packs

  is_file_server_enabled    = var.oic_definition.is_file_server_enabled
  is_visual_builder_enabled = var.oic_definition.is_visual_builder_enabled
  state                     = var.oic_definition.state
  shape = var.oic_definition.shape

  idcs_at = jsondecode(data.local_file.idcs_token.content)["access_token"]

}

resource "local_file" "decoded_file" {
  filename = "token.tok"
  content  = base64decode(var.idcs_token)
}

#https://medium.com/oracledevs/provision-and-configure-oracle-integration-cloud-instance-using-terraform-6baa89c257a