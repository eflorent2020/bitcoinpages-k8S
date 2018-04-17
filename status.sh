#/bin/sh

export $(cat .env | xargs)

gcloud compute addresses describe bitcoinpages-ip --region $REGION
kubectl get pods
kubectl get service
gcloud compute forwarding-rules list
kubectl describe svc nginx --namespace nginx-ingress
kubectl describe svc wallet --namespace wallet
gcloud container clusters describe $CLUSTER_NAME
echo ""
