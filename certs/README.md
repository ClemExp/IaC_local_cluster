# Secrets are specific to namespaces, so we may need to create the TLS secret across namespaces e.g.
kubectl -n kube-system create secret tls traefik-tls-cert --key=privkey.pem --cert=cert.pem

# Check how long cert is valid for:
cat cert.pem | openssl x509 -noout -enddate
