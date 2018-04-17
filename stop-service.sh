#/bin/sh

export $(cat .env | xargs)

# setup namespaces

kubectl delete -f wallet/namespace.yml
kubectl delete -f lego/namespace.yml
kubectl delete -f nginx/namespace.yml

# Nginx

kubectl delete -f nginx/default-deployment.yml
kubectl delete -f nginx/default-service.yml

# Nginx ingress

kubectl delete -f nginx/configmap.yml
kubectl delete -f nginx/service.yml
kubectl delete -f nginx/rbac.yml
kubectl delete -f nginx/deployment.yml

# Wallet

kubectl delete -f wallet/service.yml
kubectl delete -f wallet/deployment.yml
kubectl delete -f wallet/ingress-notls.yml


kubectl delete -f lego/configmap.yml
kubectl delete -f lego/service-account.yaml
kubectl delete -f lego/cluster-role.yaml
kubectl delete -f lego/cluster-role-binding.yaml
kubectl delete -f lego/deployment.yml

# TLS for app 
kubectl delete -f wallet/ingress-tls.yml