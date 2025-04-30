# tflint-ignore: terraform_unused_declarations
data "local_file" "idcs_token" {
  filename = "token.tok"
  depends_on = [ null_resource.get_idcs_token ]
}