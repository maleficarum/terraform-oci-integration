resource "oci_integration_integration_instance" "oic_instance" {
  compartment_id            = var.oic_definition.compartment
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
    command = <<EOT
        curl -X POST  ${var.idcs_domain}/oauth2/v1/token -H 'Authorization: Basic ${base64encode(format("%s:%s", var.idcs_client_id, var.idcs_client_secret))}' -d 'grant_type=client_credentials&scope=urn:opc:idm:__myscopes__' | jq '.' > token.tok
      EOT
  }

  triggers = {
    "build_number" = timestamp()
  }
}

#https://medium.com/oracledevs/provision-and-configure-oracle-integration-cloud-instance-using-terraform-6baa89c257a
/*


curl --location 'https://idcs-7904b09d0d2a4c13a63a4300dad1617c.identity.oraclecloud.com:443/oauth2/v1/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--header 'Authorization: Basic YTEwZDFlOTBlMGU4NGYwZmE4OTA5MGEzNGU3ZTJlYWQ6aWRjc2NzLTA1NWE5ODJmLWQ1ZDAtNDI4Yi1iODk0LTFkMTZkMjdmMjE0YQ==' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'scope=urn:opc:idm:__myscopes__'
*/