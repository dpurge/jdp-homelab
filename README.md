# jdp-homelab

Homelab IaC scripts.

Kubernetes is managed with ArgoCD and Kustomize.

Other servers are managed with Ansible.

Required tools:

- k3d
- kustomize
- argocd

## Development

Use k3d environment.

```sh
k3d cluster create devcluster
kubectl cluster-info
kubectl get all
k3d cluster delete devcluster
```

To test manifests:

```sh
kustomize build . | more
```

To install or delete:

```sh
kustomize build . | kubectl apply -f -
kustomize build . | kubectl delete -f -
```

Browse to the ArgoCD GUI (<https://localhost:8080/>):

```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
argocd login 127.0.0.1:8080
```

Browse to the Argo Workflows GUI (<https://localhost:8080/>):

```sh
kubectl -n argo port-forward svc/argo-server 2746:2746
```

## Development environment

Use ArgoCD instance per environment (they are independent and small).

Create ArgoCD application:

```sh
argocd app create argo-cd \
  --repo https://github.com/dpurge/jdp-homelab.git \
  --path kubernetes/environments/dev/argo-cd \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace argocd
```

## Workflows

```sh
kubectl create namespace workflows
kubectl create -f ./hello-world.yaml  
```
