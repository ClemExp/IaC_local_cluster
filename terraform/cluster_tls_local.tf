# Local deploy of Lets encrypt CA generated traefik certificates - post cluster create
resource "null_resource" "cluster_tls" {

  depends_on = [kind_cluster.default]

  provisioner "local-exec" {
    interpreter = local.is_windows ? ["PowerShell", "-Command"] : ["/bin/bash", "-c"]
    command = <<EOT
      set -e
      echo 'Applying TLS Config with kubectl...'
      kubectl create namespace tools
      kubectl -n tools create configmap traefik-cert --from-file=../certs/fullchain.pem
      kubectl -n tools create configmap traefik-key --from-file=../certs/privkey.pem
      kubectl -n tools create secret tls traefik-tls-cert --key=../certs/privkey.pem --cert=../certs/fullchain.pem
    EOT
  }
}