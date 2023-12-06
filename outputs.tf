output "documents" {
  value = local.documents
  description = "List of manifest documents"
}
output "documents_per_id" {
  value = local.documents_per_id
  description = "Map of manifest documents per id. The id is generated using this pattern: '/apis/{apiVersion}(/namespaces/{namespace})/{kind}/{name}'"
}
