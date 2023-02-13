# Local shell deploy of exisitng traefik chart - injecting environment = subdomain
resource "null_resource" "traefik_deploy" {

  depends_on = [null_resource.cluster_tls]

  provisioner "local-exec" {
    command = "helm install traefik ../Helm/traefik-dashboard --values ../Helm/traefik-dashboard/values.yaml --set varsubdomain='127.0.0.1.traefik.me' -n traefik --create-namespace"
    interpreter = local.is_windows ? ["PowerShell", "-Command"] : []
  }
}