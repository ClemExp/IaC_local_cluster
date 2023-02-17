# Local shell deploy of existing traefik chart - injectin environment = subdomain
resource "null_resource" "harbor_deploy" {

    depends_on = [
      null_resource.rancher_deploy
    ]

    provisioner "local-exec" {
      command = "helm install harbor ../Helm/harbor --values ../Helm/harbor/values.yaml --set varsubdomain='traefik.me' -n tools"
      interpreter = local.is_windows ? ["PowerShell", "-Command"] : []
    }
}
