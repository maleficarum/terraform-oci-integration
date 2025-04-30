variable "oic_definition" {
  type = object({
    name = string,
    instance_type             = string, # ["STANDARDX", "ENTERPRISEX"]
    is_byol                   = string,
    message_packs             = number,
    is_file_server_enabled    = string,
    is_visual_builder_enabled = string,
    state                     = string, #["INACTIVE", "ACTIVE"]
    shape                     = string  #[DEVELOPMENT, PRODUCTION, PRODUCTION_XSMALL, PRODUCTION_SMALL, PRODUCTION_MEDIUM, PRODUCTION_LARGE]
  })
  description = "The OIC definition"
}

variable "idcs_domain" {
  type        = string
  description = "IDCS Domain"
  sensitive   = true
}

variable "idcs_client_id" {
  type        = string
  description = "IDCS Client id"
  sensitive   = true
}

variable "idcs_client_secret" {
  type        = string
  description = "IDCS Client Secret"
  sensitive   = true
}

variable "compartment_id" {
  type        = string
  description = "The compartment OCID to deploy de instnace"
}