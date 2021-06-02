###### on client (linux or osx)
###############################
# copy kubeconfig from the remote
USER=packer
MASTER_IP=192.168.1.61 # master ip

scp $USER@$MASTER_IP:/home/$USER/k3s.yaml k3s.yaml # supply a password

sed -i "" "s/127.0.0.1/$MASTER_IP/g" k3s.yaml
mkdir -p ~/.kube
touch ~/.kube/config
cp ~/.kube/config ~/.kube/config.bak 
KUBECONFIG=k3s.yaml:~/.kube/config kubectl config view --flatten > config 
mv config ~/.kube/config
rm ~/.kube/config.bak
chmod go-r ~/.kube/config

# install kubectl (https://kubernetes.io/docs/tasks/tools/)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo chown root: /usr/local/bin/kubectl
kubectl version --client

# install helm3
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash