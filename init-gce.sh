#/bin/sh

export $(cat .env | xargs)

gcloud config set project $PROJECT
gcloud config set compute/zone $ZONE

gcloud container clusters create $CLUSTER_NAME --num-nodes=$NUM_NODES --preemptible

gcloud sql users create proxyuser cloudsqlproxy~% --instance=mysql --password=$MYSQL_ROOT_PASSWORD

kubectl create clusterrolebinding myname-cluster-admin-binding --clusterrole=cluster-admin --user=emmanuel.florent@gmail.com
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-lego:default
kubectl create clusterrolebinding nginx-on-cluster-admi2 --clusterrole=cluster-admin --serviceaccount=nginx-ingress:default

