# Kube Manifest Documents module

This terraform module helps to split a kubernetes multi-document manifest into several documents.

This is a replacement for the buggy [kubectl_file_documents](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/kubectl_file_documents) data source from `alekc/kubectl` or `gavinbunney/kubectl` providers.

# Usage

📗 See complete example in the [examples](./examples) directory.

## Example using `for_each`

To split and apply documents using `for_each`:

Note: This is the prefered way as mentioned in [kubectl_file_documents](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/data-sources/kubectl_file_documents) documentation:
> This ensures that any additional yaml documents or removals do not cause a large amount of terraform changes

```terraform
# Split manifest into documents
module "my_manifest" {
  source = "boillodmanuel/manifest-documents/null"
  content = file("${path.module}/manifests/my-manifest.yaml")
}

# Apply manifest documents using "hashicorp/kubernetes" provider
resource "kubernetes_manifest" "my_custom_resource" {
  for_each = module.my_manifest.documents_per_id
  manifest = yamldecode(each.value)
}
```

## Example using `count`

To split and apply documents using `count`: 

```terraform
# Split manifest into documents
module "my_manifest" {
  source = "boillodmanuel/manifest-documents/null"
  content = file("${path.module}/manifests/my-manifest.yaml")
}

# Apply manifest documents using "hashicorp/kubernetes" provider
resource "kubernetes_manifest" "my_custom_resource" {
  count = length(module.my_manifest.documents)
  manifest = yamldecode(module.my_manifest.documents[count.index])
}
```

# Terraform module documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content"></a> [content](#input\_content) | Content of a multi-documents manifest. The content MUST be known before apply. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_documents"></a> [documents](#output\_documents) | List of manifest documents |
| <a name="output_documents_per_id"></a> [documents\_per\_id](#output\_documents\_per\_id) | Map of manifest documents per id. The id is generated using this pattern: '/apis/{apiVersion}(/namespaces/{namespace})/{kind}/{name}' |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

