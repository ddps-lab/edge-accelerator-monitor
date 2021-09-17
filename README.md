# edge-accelerator-monitor

Accelerator-Aware Kubernetes Schedulerfor DNN Tasks on Edge Computing Environment

### Run Docker on Nvidia Jetson, Coral TPU Rasberry pi 4 machine(GPU)
```
sudo apt-get remove docker docker.io containerd runc nvidia-docker2
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install containerd.io docker-ce docker-ce-cli
sudo docker pull kmubigdata/edge-accelerator-monitor
sudo docker run -it --privileged --name [docker container name] kmubigdata/edge-accelerator-monitor:latest /bin/bash
```

### Kubernetes install
```
sudo apt-get update && apt-get install -y apt-transport-https curl
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo echo deb http://apt.kubernetes.io/ kubernetes-xenial main > /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm
```

### Run Kubernetes DaemonSet on Cluster environment
Machine hardware data extraction available (model, resource usage, drvier version)

```
sudo kubectl apply -f Daemonset.yaml
sudo kubectl get daemonset
sudo kubectl get pod -o wide
```
