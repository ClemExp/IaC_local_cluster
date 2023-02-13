# Local deploy of Lets encrypt CA generated traefik certificates - post cluster create
resource "null_resource" "cluster_tls" {

  depends_on = [kind_cluster.default]

  provisioner "local-exec" {
    interpreter = local.is_windows ? ["PowerShell", "-Command"] : ["/bin/bash", "-c"]
    command = <<EOT
      set -e
      echo 'Applying TLS Config with kubectl...'
      kubectl create namespace traefik
      kubectl create namespace cattle-system
      kubectl -n traefik create configmap traefik-cert --from-file=../certs/cert.pem
      kubectl -n traefik create configmap traefik-key --from-file=../certs/privkey.pem
      kubectl -n cattle-system create secret tls traefik-tls-cert --key=../certs/privkey.pem --cert=../certs/cert.pem
    EOT
  }
}