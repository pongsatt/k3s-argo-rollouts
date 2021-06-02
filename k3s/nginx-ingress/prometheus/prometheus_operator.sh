helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create ns prometheus

# https://github.com/bitnami/charts/tree/master/bitnami/kube-prometheus/#installing-the-chart
helm upgrade -i -n prometheus kube-prometheus bitnami/kube-prometheus

# helm uninstall kube-prometheus

# explore this later https://github.com/prometheus-operator/prometheus-operator
