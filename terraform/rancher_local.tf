# Local shell deploy of exisitng traefik chart - injecting environment = subdomain
resource "null_resource" "rancher_deploy" {

  depends_on = [null_resource.wait_for_ingress_traefik]

  provisioner "local-exec" {
    command = "helm install rancher ../Helm/rancher --values ../Helm/rancher/values.yaml --set varsubdomain='traefik.me' -n tools"
    interpreter = local.is_windows ? ["PowerShell", "-Command"] : []
  }
}

resource "null_resource" "wait_for_ingress_traefik" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    interpreter = local.is_windows ? ["PowerShell", "-Command"] : []
    # All jobs are given a label of "job-name" so you can filter based on whether the pod has that label
    command = <<EOF
      printf "\nWaiting for the traefik ingress controller...\n"
      kubectl wait --selector='!job-name' --for=condition=ready --timeout=60s -n tools --all pods
    EOF
  }

  depends_on = [null_resource.traefik_deploy]
}