# initial install service
kubectl apply -f ./blue-green-rollouts-demo

# see on dashboard
kubectl argo rollouts dashboard
open http://localhost:3100

# access service ui (192.168.1.61 is master node's ip)
open http://blue-green-rollouts-demo.192.168.1.61.nip.io
