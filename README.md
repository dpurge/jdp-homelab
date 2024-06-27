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

```sh
cd kubernetes/environments/dev/applications/
kubectl apply -f argo-cd.yaml
```

Browse to the ArgoCD GUI (<https://localhost:8080/>):

```sh
kubectl port-forward svc/argocd-server -n argocd 80:80
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
argocd login 127.0.0.1:8080
# Set "admin" password to be "password" for easy testing
#bcrypt(password)=$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa
kubectl -n argocd patch secret argocd-secret -p '{"stringData": {"admin.password": "$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa","admin.passwordMtime": "2023-10-02T21:47:40CEST"}}'
```

```pwsh
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | %{ [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) }
```

Reset password to the pod name:

```sh
kubectl -n argocd patch secret argocd-secret  -p '{"data": {"admin.password": null, "admin.passwordMtime": null}}'
kubectl -n argocd scale deployment argocd-server --replicas=0
kubectl -n argocd scale deployment argocd-server --replicas=1
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

Updating secrets:

```sh
kubectl -n workflows get secrets workflow-secrets -o json \
  | jq '.data["github-password"] |= "<ENCODED-BASE64>"' \
  | kubectl apply -f -
```

Grant access to workflow service account:

```sh
kubectl create rolebinding default-admin --clusterrole=admin --serviceaccount=workflows:default --namespace=workflows
```

Run workflow manually:

```sh
argo submit --from cronwf/youtube-download -n workflows
argo submit --from cronwf/langnotes-build -n workflows
argo submit --from cronwf/flashcards-build -n workflows
```

## Traefik

```sh
kubectl create namespace traefik
kubectl get all --namespace traefik
helm install traefik traefik/traefik --namespace traefik --dry-run
```
