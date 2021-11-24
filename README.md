# edge-accelerator-monitor

Link : Accelerator-Aware Kubernetes Schedulerfor DNN Tasks on Edge Computing Environment


## Configure a Kubernetes cluster environment for edge accelerator hardware information extraction and automatic labeling


### 1. Docker install
```
apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update
apt-get install containerd.io docker-ce docker-ce-cli
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
swapoff -a
rm /etc/systemd/nvzramconfig.sh
```

### 4. Kubernetes cluster setting (master node)

Cluster api initialization on the master node and the token is issued.

```
kubeadm init --apiserver-advertise-address=192.168.0.5 --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.18.14
```
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

How to reissue a token

```
kubeadm token create --print-join-command
```

### 5. Kubernetes cluster setting (worker node)

Join the cluster using the token value from the worker node.

```
kubeadm join 192.168.0.5:6443 --token [token data] --discovery-token-ca-cert-hash [token hash data]
```

In Google Coral TPU device, execute join after setting cgroup memory.

```
sudo vi /boot/firmware/nobtcmd.txt
cgroup_ena vv b ble=cpuset cgroup_enable=memory cgroup_memory=1 
sudo reboot
```

### 6. Flannel network plugin install (master node)

Tasks to configure the container's network and assign an IP

```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.13.0/Documentation/kube-flannel.yml
```


### 7. worker node role setting (master node)

```
kubectl label node [node name] node-role.kubernetes.io/worker=worker
```

### 8. Kubernetes cluster setting check (master node)

```
kubectl get nodes
```

### 9. separate settings (master node)

```
kubectl get nodes
```
