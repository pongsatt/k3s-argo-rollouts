# initial install service
kubectl apply -f ./basic-rollouts-demo

# see on dashboard
kubectl argo rollouts dashboard
open http://localhost:3100

# access service ui (192.168.1.61 is master node's ip)
open http://basic-rollouts-demo.192.168.1.61.nip.io
