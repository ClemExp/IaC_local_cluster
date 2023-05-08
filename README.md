# Kind & terraform: Local test repository

This repo is for the automated (IaC) install & setup of a kind Kubernetes cluster in a local environment (can be on a laptop or VM).

Repository can be run on Windows or Linux, with the baseline software requirements below pre-installed.

To run the repository, you just need to ensure base software is installed, git clone the repo & then run terraform (init and apply).

Will install and configure the cluster for TLS, installing base cluster tools (traefik, rancher, harbor).

The cluster DNS is setup with traefik.me, which is a special DNS lookup, returning the localhost IP of the server it is called from.
This will enable us to use traefik.me in the application URLs.
Certificates are retrievable from https://traefik.me/ and updated every 60 days.

## Installation

First as the cluster and cluster tools will require a lot of resources, I recommend to install this cluster on an environment with 16GB RAM. Or selectively install cluster tools as needed (e.g. rancher for cluster UI may not be required)
### Docker daemon/Docker desktop
I recommend to use docker desktop instead of docker daemon, so you can avoid using windows WSL on a windows environment.

### Chocolatey/Choco
We would first need to install the chocolatey/choco installer for Windows 10. To do this, as an administrator, we will open the PowerShell console and type the following:

```
Set-ExecutionPolicy Bypass -Scope Process -Force; `
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
We will hit "Yes" and the download and installation of choco will start.
This will help us to install many of the applications we will need next.
### Kubectl
Once choco is installed, we proceed with the installation of kubectl, for this, from the PowerShell as administrator, we execute the following command.
```
choco install kubernetes-cli
```
Kubectl is used to manage everything related to Kubernetes, such as clusters, nodes,... With it we can raise nodes, see the logs of what is happening in those nodes, delete clusters/nodes, etc.
### Kind
kind is a tool for running local Kubernetes clusters using Docker container "nodes". kind was primarily designed for testing Kubernetes itself, but may be used for local development or CI. To install it, run this command:
```
choco install kind
```
### Helm
Helm helps you manage Kubernetes applications — Helm Charts help you define, install, and upgrade even the most complex Kubernetes application. Run this command to install it:
```
choco install kubernetes-helm
```
### Terraform
Terraform is HashiCorp's infrastructure as code tool. It lets you define resources and infrastructure in human-readable, declarative configuration files, and manages your infrastructure's lifecycle. It is installed using the following command:
```
choco install terraform
```

## Access details
After installation tools are available via the following URLs

| Service | URL  			      		                         | Access               |
|---------|---------------------------------------------------------------------|
| Traefik | https://traefik.trafik.me/dashboard/#/ 		   | traefik/admin12345   |
| Rancher | https://rancher.trafik.me/                   | admin/admin          |
| Harbor  | https://harbor.trafik.me/ 	                 | admin/Harbor12345    |


<br />

## Certificate management
For local clusters it is easier to communicate via HTTP only, however several of the cluster tools we use do not work well (or at all) unless HTTPS is in place. This is the case for Rancher, K8s dashboard, image pulling from harbor etc.

So, we will use a "bring your own certificate" setup, with the wildcard certificates from traefik.me. Traefik.me is a public DNS server based on nip.io, which strips out the IP in the DNS entry to resolve to a local network IP e.g. 127.0.0.1.traefik.me - will resolve to 127.0.0.1 or tst.traefik.me - will also resolve to localhost (once we have the subdomain tst defined in traefik), which is perfect for local testing.

For staging/ops environment clusters, we perform automatic certificate renewal (lets encrypt with CSG, potentially AWS cert manager for AWS) via a cert resolver. For local clusters however, due to let's encrypt limits (50 per week), we won't be able to automatically renew every time for nip.io, traefik.me.

Therefore we choose to "bring your own certificates" for the local cluster, and not use the certificate resolver. We could generate our own certificates as well with OpenSSL, or mkcert, but these would always not be trusted and we will have the annoying message in the browsers when accessing on HTTPS. Could also pose a problem in harbor pulls.

Wildcard certificates from traefik.me are from a trusted CA (let's encrypt), and are renewed every 60-90 days. The repository needs to be up to date with these certs for HTTPS to work (certificates renewed regularly in traefik.me).

Certificates are imported into the cluster via configmaps, and then mounted into the traefik pod(s) via volume mounts in the case of traefik for the default certificate configuration or via secrets for additional applications. Note: we are using the full chain (root and certificate) in the TLS secrets we create in the cluster instead of the certificate alone. We found this necessary for performing a helm install with harbor image pulls.

Traefik, as the cluster ingres controller, is configured with local traefik.me certs (included in the repo - certs folder).
