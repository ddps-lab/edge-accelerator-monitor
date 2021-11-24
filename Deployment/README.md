# Kubernetes ServiceAccount, Daemonset

Manage kubernetes clustered hardware device nodes.    
Hardware information extraction and automatic labeling.

### 1. ServiceAccount.yaml
This is a file that grants permission to access the deployed accelerator information extraction container and label its own node.

### 2. ARM64-Daemonset.yaml
This is a file that enables the accelerator information extraction container to be deployed on NVIDIA Jetson TX1, TX2, Nano, Xavier and Google Coral TPU device nodes with ARM64 architecture.

### 3. AMD64-Daemonset.yaml
This is a file that enables the accelerator information extraction container to be deployed on the NVIDIA GPU device node with the AMD64 architecture.


### How to apply a file
```
kubectl apply -f ServiceAccount.yaml
kubectl apply -f ARM64-Daemonset.yaml
kubectl apply -f AMD64-Daemonset.yaml
```
### How to check Daemonset, pod, container, label
```
kubectl get daemonset
kubectl get pod -o wide
kubectl get node --show-labels
```
### How to delete a file
```
kubectl delete -f ServiceAccount.yaml
kubectl delete -f ARM64-Daemonset.yaml
kubectl delete -f AMD64-Daemonset.yaml
```
