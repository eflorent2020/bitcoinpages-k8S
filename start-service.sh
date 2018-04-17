#/bin/sh

export $(cat .env | xargs)

# setup namespaces

kubectl apply -f wallet/namespace.yml
kubectl apply -f lego/namespace.yml
kubectl apply -f nginx/namespace.yml

# Config map
#kubectl create configmap lbip --namespace nginx-ingress --from-literal=LB_IP=$LB_IP

# Secrets
kubectl create secret generic mysql --namespace wallet --from-literal=password=$MYSQL_ROOT_PASSWORD
kubectl create secret generic cloudsql-instance-credentials --namespace wallet --from-file=credentials.json=bitcoinpages-mysqlsecret.json
kubectl create secret generic cloudsql-db-credentials --namespace wallet --from-literal=username=proxyuser --from-literal=password=$MYSQL_ROOT_PASSWORD

kubectl create secret generic bitcoinrpcuser --namespace wallet --from-literal=password=$BITCOIN_RPC_USER
kubectl create secret generic bitcoinrpcauth --namespace wallet --from-literal=password=$BITCOIN_RPC_AUTH


# Nginx

kubectl apply -f nginx/default-deployment.yml
kubectl apply -f nginx/default-service.yml

# Nginx ingress

kubectl apply -f nginx/configmap.yml
kubectl apply -f nginx/service.yml
kubectl apply -f nginx/rbac.yml
kubectl apply -f nginx/deployment.yml

echo "Waiting 60s for Nginx to come up ..."
sleep 60
kubectl describe svc nginx --namespace nginx-ingress

# Wallet

kubectl apply -f wallet/service.yml
kubectl apply -f wallet/deployment.yml

echo "Waiting 60s for Wallet to come up ..."
sleep 60
kubectl describe svc wallet --namespace wallet


kubectl apply -f wallet/ingress-notls.yml
echo "Waiting 60s for Wallet to come up ..."
sleep 60


# Kubelego

kubectl apply -f lego/configmap.yml
# Kubelego's RBAC
kubectl apply -f lego/service-account.yaml
kubectl apply -f lego/cluster-role.yaml
kubectl apply -f lego/cluster-role-binding.yaml
# Deployement
kubectl apply -f lego/deployment.yml

# TLS for app 
kubectl apply -f wallet/ingress-tls.yml

echo "Waiting 20s for 2nd Ingress to come up ..."
sleep 20
./status.sh


