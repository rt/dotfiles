# Micro Service / Micro Frontend Prototype

```bash

cd ~/projects/playground/remira-impl
npm run build apps/ecom-spec/ server ~/projects/playground-cloud/prototype/monorepo/items/ ../services/server-nodejs/
npm run build apps/ecom-spec/ server ~/projects/playground-cloud/prototype/monorepo/logic/ ../services/server-nodejs/

```

### 1. Enable K8s, Helm, and Dashboard

```
# brew install kubernetes-cli (This is already installed)
# select Kubernetes > docker-for-desktop in UI
kubectl config use-context docker-desktop
kubectl config current-context
kubectl config view
```
*Helm*

helm consists of a client (helm) and a cluster side component (tiller), that
can get installed through the client. The client is a single binary file.helm
consists of a client (helm) and a cluster side component (tiller)

Download Helm client https://github.com/helm/helm/releases/tag/v3.1.1

```bash
sudo mv ~/Downloads/darwin-amd64/helm /usr/local/bin/
helm init             #install tiller
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update
```

*kubernetes-dashboard*

https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboardhttps://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

```bash
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

# this makes it only available on localhost
kubectl port-forward kubernetes-dashboard-xxx 8443:8443 -n kube-system    

# make it available elsewhere
kubectl proxy
# visit http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

# you'll be asked to enter a token
kubectl describe secret kubernetes-dashboard -n kube-system

# or setup a user https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md
```

✓ You should have access to dashboard


*Create Namespace*
By creating the namespace it allows us to get the default ServiceAccount (not necessarily good, see reference)
```
kubectl create -f kubernetes/namespace.yaml
```

*Create ServiceAccount (gitlab-ci)*

```
kubectl create -f kubernetes/rbac.yaml
```

*Get ServiceAccount Token (gitlab-ci-token)*

A service account get a token, let's grab that.
```
kubectl get secret -n skeleton-devops
```

Get the NAME outputted from the above command to get the encoded token
```
kubectl get -n skeleton-devops secret <NAME> -o yaml
```

Look for data > token: and decode it
```
echo YOUR_TOKEN_HERE | base64 -d > decoded_token
```

✓ You should have a new decoden_token file

*Get Kubernetes CA Certificate*

For docker-desktop you can do the following
```
kubectl cp kube-apiserver-docker-desktop:run/config/pki/ca.crt -n kube-system ca.crt
```

✓ You should have a new ca.crt file

*API URL*

```
kubectl cluster-info | grep 'Kubernetes master' | awk '/http/ {print $NF}'
# https://kubernetes.docker.internal:6443
```

✓ You now have all the info to register kubernetes in GitLab


If lazy to add cert, do this workaround

```
GIT_SSL_NO_VERIFY=true git push
```
Or,
```
git config --global http.sslVerify false
```






```
kubectl create \
    -n skeleton-devops \
    secret docker-registry registry-gitlab-key \
    --docker-server=gitlab.pebblefields.com:5050 \
    --docker-username=root \
    --docker-password=vDZkyB6VzevDgzNZzkAN
```

Add the secret to the service account
I couldn't the get pods to use the gitlab-ci service account, it only worked with the default service account.
Might be able to solve, read this https://medium.com/better-programming/k8s-tips-using-a-serviceaccount-801c433d0023
```
# kubectl patch -n skeleton-devops serviceaccount gitlab-ci -p '{"imagePullSecrets": [{"name": "registry-gitlab-key"}]}'
kubectl patch -n skeleton-devops serviceaccount default -p '{"imagePullSecrets": [{"name": "registry-gitlab-key"}]}'
```




*Configuration Changes*
```
helm upgrade -n skeleton-devops -f values.yaml gitlab-runner gitlab/gitlab-runner
```
if doesn't go well
```
helm uninstall -n skeleton-devops gitlab-runner
helm install -n skeleton-devops gitlab-runner -f values.yaml gitlab/gitlab-runner
```
It will register again, so you probably need to delete the old registered runner in admin.


---

The scenario is there is a monolith legacy app that releases from branches.

*envs*
- dev (master, current prod)
- uat (master)
- qa (master, current prod)
- prod (current prod)

*components*
- app
- database
- memcache

**CI/CD**

Is not considered here but typically you would interpolate template manifest files.
Use a script so that you can show locally without worrying about ci/cd infrastructure.

*CI/CI Script*
- Test
- Build/Push images
- Build and apply manifests


Without script yet, manually do the following
```bash

# nginx-ingress-controller is not installed on Docker for mac
# use the following to enable
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.43.0/deploy/static/provider/cloud/deploy.yaml

DOCKER_USER_ID=pebble
cd monorepo

# Logic
(cd logic && npm ci && npm run build)
docker build -f logic/Dockerfile -t $DOCKER_USER_ID/logic logic/
docker push $DOCKER_USER_ID/logic
kubectl apply -f logic/manifests/service.yaml
kubectl apply -f logic/manifests/deployment.yaml --record
kubectl rollout status deployment logic

kubectl delete service logic
kubectl delete deployment logic


# items
(cd items && npm ci && npm run build)
docker build -f items/Dockerfile -t $DOCKER_USER_ID/items items/
docker push $DOCKER_USER_ID/items
kubectl apply -f items/manifests/service.yaml
kubectl apply -f items/manifests/ingress.yaml
kubectl apply -f items/manifests/deployment.yaml --record
kubectl rollout status deployment items

kubectl delete service items
kubectl delete deployment items
kubectl delete ingress items

# Frontend 
(cd frontend && npm ci && npm run build)
docker build -f frontend/Dockerfile -t $DOCKER_USER_ID/frontend frontend/
docker push $DOCKER_USER_ID/frontend
kubectl apply -f frontend/manifests/service.yaml
kubectl apply -f frontend/manifests/ingress.yaml
kubectl apply -f frontend/manifests/deployment.yaml --record
kubectl rollout status deployment frontend

kubectl delete service frontend
kubectl delete deployment frontend
kubectl delete ingress frontend

# confirm
kubectl get pods
kubectl get deployments
kubectl get services
kubectl get ingress

kubectl describe ingress items
kubectl describe deployment items
kubectl describe service items
kubectl describe pod mypod

```

*.gitlab-ci.yml*
```yaml
image: node:latest

before_script:

stages:
  - build
  # - test
  - release
  - deploy

cache:
  paths:
    - node_modules/

install_dependencies:
  stage: build
  script:
    - npm install
    - npm run build
  artifacts:
    paths:
      - build/
      - node_modules/

# testing_testing:
#   stage: test
#   script: npm test

image_build:
  stage: release
  image:
    name: docker:stable
    entrypoint:
      - /bin/sh
      - -c
  services:
    - name: docker:18.09.7-dind
      entrypoint:
        - /bin/sh
        - -c
        - dockerd-entrypoint.sh --insecure-registry gitlab.pebblefields.com:5050 || exit
  variables:
    DOCKER_HOST: tcp://localhost:2375
    DOCKER_TLS_CERTDIR: ""
  script:
    - docker login -u "${CI_REGISTRY_USER}" -p "${CI_REGISTRY_PASSWORD}" "${CI_REGISTRY}"
    - docker build -t "${CI_REGISTRY_IMAGE}:latest" .
    - docker tag "${CI_REGISTRY_IMAGE}:latest" "${CI_REGISTRY_IMAGE}:${CI_COMMIT_REF_NAME}"

      # only if there is a tag do we push :latest
    - test ! -z "${CI_COMMIT_TAG}" && docker push "${CI_REGISTRY_IMAGE}:latest"

      # this would keep overwriting :master
    - docker push "${CI_REGISTRY_IMAGE}:${CI_COMMIT_REF_NAME}"

deploy_live:
  image:
    name: lachlanevenson/k8s-kubectl:latest
    entrypoint: ["/bin/sh", "-c"]
  stage: deploy
  only:
    - master
  environment:
    name: live
  script:
    - kubectl version
    - cd manifests/
    - sed -i "s~__CI_REGISTRY_IMAGE__~${CI_REGISTRY_IMAGE}~" deployment.yaml
    - sed -i "s~__CI_PROJECT_NAME__~${CI_PROJECT_NAME}~" deployment.yaml ingress.yaml service.yaml
    - sed -i "s/__VERSION__/${CI_COMMIT_REF_NAME}/" deployment.yaml
    - |
      if kubectl apply -f deployment.yaml | grep -q unchanged; then
          echo "=> Patching deployment to force image update."
          kubectl patch -f deployment.yaml -p "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"ci-last-updated\":\"$(date +'%s')\"}}}}}"
      else
          echo "=> Deployment apply has changed the object, no need to force image update."
      fi
    - kubectl apply -f service.yaml || true
    - kubectl apply -f ingress.yaml
    - kubectl rollout status -f deployment.yaml
    - kubectl get deploy,svc,ing,pod -l app="$(echo ${CI_PROJECT_NAME} | tr "." "-")"
```

### Setup

**Deployment of legacy (prod)**
For purposes here, put up a legacy stack to represent prod.

```bash
kubectl apply -f legacy/manifests/deployment.yaml --record
```

**Deployment of legacy (uat)**
For each job (k8s on the each vm)

**Deployment of legacy (qa)**
For each job (k8s on the each vm)

**Deployment of legacy (dev)**
Current devenv (k8s on docker for mac/minikube/multipass)


### Build first micro service


### Rollback



```bash

kubectl rollout history deployment sa-frontend
kubectl rollout undo deployment sa-frontend --to-revision=2

kubectl describe deployment sa-frontend

kubectl delete deployment sa-frontend

```


```bash

kubectl apply -f frontend/manifests/sa-frontend-pod.yaml
kubectl apply -f frontend/manifests/sa-frontend-pod2.yaml 

kubectl get pod -l app=sa-frontend

kubectl get pods --show-labels

kubectl create -f service-sa-frontend-lb.yaml
kubectl get svc


kubectl apply -f sa-frontend-deployment.yaml

```


