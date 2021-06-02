helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

kubectl create namespace ingress-nginx
helm upgrade -i -n ingress-nginx ingress-nginx ingress-nginx/ingress-nginx \
--set controller.metrics.enabled=true \
--set controller.metrics.serviceMonitor.enabled=true

# helm upgrade -i -n ingress-nginx ingress-nginx ingress-nginx/ingress-nginx \
# --set controller.metrics.enabled=true \
# --set-string controller.podAnnotations."prometheus\.io/scrape"="true" \
# --set-string controller.podAnnotations."prometheus\.io/port"="10254"