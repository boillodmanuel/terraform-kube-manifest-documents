# Split manifest into documents
module "my_manifest" {
  source = "boillodmanuel/manifest-documents/null"
  content = file("multi-documents.yaml")
}

# Apply manifest documents using "hashicorp/kubernetes" provider
resource "kubernetes_manifest" "my_custom_resource_for_each" {
  for_each = module.my_manifest.documents_per_id
  manifest = yamldecode(each.value)
}

# Apply manifest documents using "hashicorp/kubernetes" provider
resource "kubernetes_manifest" "my_custom_resource_count" {
  count = length(module.my_manifest.documents)
  manifest = yamldecode(module.my_manifest.documents[count.index])
}
