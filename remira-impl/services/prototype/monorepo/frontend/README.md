# frontend

The dev should be able to 
- run and test the app.
- build the image and test locally


**Dev**

```bash
npm start
npm test
...
```

**Build image**

```bash
# Build app
npm run build

DOCKER_USER_ID=pebble
docker build -f Dockerfile -t $DOCKER_USER_ID/frontend .

# Kubernetes needs a registry to pull image from
docker push $DOCKER_USER_ID/frontend

```

**Test image**

- Change image in deployment file
- Run a pod with the right label

```bash
# Docker (useless?)
docker run -d -p 3001:80 $DOCKER_USER_ID/sentiment-analysis-frontend

# K8s (useless?)
kubectl apply -f manifests/sa-frontend-pod.yaml
kubectl get pods
kubectl exec -it sa-frontend -- /bin/bash
kubectl port-forward sa-frontend 8888:80



# run higher up system tests ...

```

