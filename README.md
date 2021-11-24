# edge-accelerator-monitor

[Accelerator-Aware Kubernetes Scheduler for DNN Tasks on Edge Computing Environment](https://edge-k8s-project.s3.amazonaws.com/Accelerator-Aware+Kubernetes+Scheduler+for+DNN+Tasks+on+Edge+Computing+Environment.pdf)


Configure a Kubernetes cluster environment for edge accelerator hardware information extraction and automatic labeling


### 1. Docker install
```
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install -y containerd.io docker-ce docker-ce-cli
```

### 2. Kubernetes install
```
sudo apt-get update && apt-get install -y apt-transport-https curl
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo echo deb http://apt.kubernetes.io/ kubernetes-xenial main > /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm
```

### 3. Disable kubernetes container swap,zram
```
sudo swapoff -a
sudo rm /etc/systemd/nvzramconfig.sh
```

### 4. Kubernetes cluster setting (master node)

Cluster api initialization on the master node and the token is issued.

```
sudo kubeadm init --apiserver-advertise-address=[master ip] --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.18.14
```
```
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

How to reissue a token

```
sudo kubeadm token create --print-join-command
```

### 5. Kubernetes cluster setting (worker node)

Join the cluster using the token value from the worker node.

```
sudo kubeadm join [master ip : port] --token [token data] --discovery-token-ca-cert-hash [token hash data]
```

In Google Coral TPU device, execute join after setting cgroup memory.

```
sudo vi /boot/firmware/nobtcmd.txt
add line >>
cgroup_ena vv b ble=cpuset cgroup_enable=memory cgroup_memory=1 

sudo reboot
```

### 6. Flannel network plugin install (master node)

Tasks to configure the container's network and assign an IP

```
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.13.0/Documentation/kube-flannel.yml
```


### 7. worker node role setting (master node)

```
sudo kubectl label node [node name] node-role.kubernetes.io/worker=worker
```

### 8. Kubernetes cluster setting check (master node)

```
sudo kubectl get nodes
```

### 9. NVIDIA GPU physical device separate settings (GPU runtime)

Register nvidia-docker related repository on host

```
sudo distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```

nvidia-docker package install

```
sudo apt-get update
sudo apt-get install -y nvidia-docker2
```

default runtime setting

```
sudo vi /etc/docker/daemon.json
add line >>
"default-runtime": "nvidia" 
```

docker daemon service restart

```
sudo systemctl restart docker
```

Install NVIDIA device plugin on master node
```
sudo kubectl apply -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/v0.9.0/nvidia-device-plugin.yml
```

