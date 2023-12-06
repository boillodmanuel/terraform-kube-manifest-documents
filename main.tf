locals {
  documents = split("---", var.content)
  
  documents_raw_and_yaml = [
    for doc in local.documents :
    {
      raw : doc,
      yaml : yamldecode(doc)
    }
  ]

  documents_per_id = {
    for doc in local.documents_raw_and_yaml :
    # Compute ID from apiversion, namespace(optional), kind and name
    lower(
      join("", [
        "/apis/",
        doc.yaml.apiVersion,
        try(join("", ["/namespaces/", doc.yaml.metadata.namespace]), ""),
        "/",
        doc.yaml.kind,
        "/",
    doc.yaml.metadata.name]))
    => doc.raw
  }
}
