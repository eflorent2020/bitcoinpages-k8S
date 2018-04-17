#!/bin/sh

export $(cat .env | xargs)

gcloud container clusters delete $CLUSTER_NAME