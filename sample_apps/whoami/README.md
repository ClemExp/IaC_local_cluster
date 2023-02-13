Sample simple application deployed via standard kubectl to local K8s cluster.
Tests to ensure ingress route created dynamically into traefik and can access application through local subdomain.
Steps:
kubectl apply -f 1_depl.yaml
kubectl apply -f 2_serv.yaml
kubectl apply -f 3_ingr.yaml

Step 3 should add routes dynamically to traefik and be accessible via http://whoami.traefik.me/
