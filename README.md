# Kind & Terraform Local test repository

This repo is for the automated (IaC) install & setup of a kind Kubernetes cluster in a local environment (can be on a laptop or VM).

Repository can be run on Windows or Linux, with the baseline software requirements below pre-installed.

To run the repository, you just need to ensure base software is installed, git clone the repo & then run terraform (init and apply).

Will install and configure the cluster for TLS, installing base cluster tools (traefik, rancher, harbor).

The cluster DNS is setup with traefik.me, which is a special DNS lookup, returning the localhost IP of the server it is called from.
This will enable us to use traefik.me in the application URLs.
Certificates are retrievable from https://traefik.me/ and updated every 60 days.

## Installation (Baseline software)

First as the cluster and cluster tools will require a lot of resources, I recommend to install this cluster on an environment with 16GB RAM. Or selectively install cluster tools as needed (e.g. rancher for cluster UI may not be required)
### Docker daemon/Docker desktop
I recommend to use docker desktop instead of docker daemon, so you can avoid using windows WSL on a windows environment.

### Windows install: Chocolatey/Choco
I would first need to install the chocolatey/choco installer for Windows 10. To do this, as an administrator, I will open the PowerShell console and type the following:

```
Set-ExecutionPolicy Bypass -Scope Process -Force; `
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
i will hit "Yes" and the download and installation of choco will start.
This will help us to install many of the applications I will need next.
### Kubectl
Once choco is installed, I proceed with the installation of kubectl, for this, from the PowerShell as administrator, I execute the following command.
```
choco install kubernetes-cli
```
Kubectl is used to manage everything related to Kubernetes, such as clusters, nodes,... With it I can raise nodes, see the logs of what is happening in those nodes, delete clusters/nodes, etc.
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