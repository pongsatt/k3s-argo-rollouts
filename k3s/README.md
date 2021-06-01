# Setup a k3s cluster
This guide is to setup a Kubernetes cluster based on [k3s](https://k3s.io/).

1. [Prepare servers](#prepare-servers)
2. [Install k3s cluster](#install-k3s-cluster)
3. [Install client to access the cluster](#install-client-to-access-the-cluster)

## Prepare servers
For windows, follow the instructions in "[windows](/infra/windows/README.md)"

## Install k3s cluster
1. Access master node with ip: 192.168.1.61

   - Option 1: Access directly using virtualbox.
   ```sh
   Login: packer
   Password: packer
   ```
   - Option 2: using ssh
   ```sh
   ssh 192.168.1.61 -l packer
   ```
2. Install k3s on master

    ```sh
    ###### on master node
    ###############################
    curl -sfL https://get.k3s.io | K3S_TOKEN=mynodetoken sh -s - --no-deploy traefik

    # prepare config file distribution
    sudo cp --no-preserve=mode /etc/rancher/k3s/k3s.yaml k3s.yaml
    ```
3. Access worker node with ip: 192.168.1.62
   ```sh
   ssh 192.168.1.62 -l packer
   ```
4. Install k3s on worker node
    ```sh
    ###### on worker node
    ###############################
    curl -sfL https://get.k3s.io | K3S_URL=https://192.168.1.61:6443 K3S_TOKEN=mynodetoken sh -
    ```
5. Repeat step 3 and 4 for ip 192.168.1.63
6. Verifing by going back to master node and run command
   ```sh
   sudo kubectl get node

   # successful output
   packer@kubemaster:~$ sudo kubectl get node
    NAME         STATUS   ROLES                  AGE   VERSION
    kubenode2    Ready    <none>                 34h   v1.20.7+k3s1
    kubemaster   Ready    control-plane,master   34h   v1.20.7+k3s1
    kubenode1    Ready    <none>                 34h   v1.20.7+k3s1
   ```

## Install client to access the cluster
1. Download k3s configuration file
   ```sh
   USER=packer
   MASTER_IP=192.168.1.61

   scp $USER@$MASTER_IP:/home/$USER/k3s.yaml k3s.yaml
   # supply a password
   ```
2. Copy config to kubectl default folder
   ```sh
    sed -i "" "s/127.0.0.1/$MASTER_IP/g" k3s.yaml
    mkdir -p ~/.kube
    touch ~/.kube/config
    cp ~/.kube/config ~/.kube/config.bak 
    KUBECONFIG=k3s.yaml:~/.kube/config kubectl config view --flatten > config 
    mv config ~/.kube/config
    rm ~/.kube/config.bak
   ```
3. Install kubectl
   ```sh
   # install kubectl (https://kubernetes.io/docs/tasks/tools/)
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    sudo chown root: /usr/local/bin/kubectl
    kubectl version --client
   ```
3. Install helm
   ```sh
   # install helm3
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
    helm version
   ```