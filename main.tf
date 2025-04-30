resource "oci_integration_integration_instance" "oic_instance" {
  compartment_id            = var.compartment_id
  display_name              = var.oic_definition.name
  integration_instance_type = var.oic_definition.instance_type
  is_byol                   = var.oic_definition.is_byol
  message_packs             = var.oic_definition.message_packs

  is_file_server_enabled    = var.oic_definition.is_file_server_enabled
  is_visual_builder_enabled = var.oic_definition.is_visual_builder_enabled
  state                     = var.oic_definition.state
  shape                     = var.oic_definition.shape

  idcs_at = jsondecode(data.local_file.idcs_token.content)["access_token"]

  depends_on = [data.local_file.idcs_token]
}


resource "null_resource" "get_idcs_token" {
  provisioner "local-exec" {
    when = create
    command = <<EOT
        curl -X POST  ${var.idcs_domain}/oauth2/v1/token -H 'Authorization: Basic ${base64encode(format("%s:%s", var.idcs_client_id, var.idcs_client_secret))}' -d 'grant_type=client_credentials&scope=urn:opc:idm:__myscopes__' | jq '.' > token.tok
      EOT
  }

  triggers = {
    "build_number" = timestamp()
  }
}

#https://medium.com/oracledevs/provision-and-configure-oracle-integration-cloud-instance-using-terraform-6baa89c257a
