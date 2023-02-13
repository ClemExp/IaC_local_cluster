# Local test repository

In this repository we can find different tests carried out in a local environment (Windows 10).

We will have two test environments. The first one is to use Helm to set up our test environment. This option is simpler than Terraform, so if you haven't seen anything related to Helm, Kubernetes, Kind,... I suggest you start with the Helm test environment.

The second one would be Terraform, for which we need to have already acquired some basic concepts.

Before downloading any of these test environments, let's see what we would have to install and how to do it in Windows 10.

## Installation
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