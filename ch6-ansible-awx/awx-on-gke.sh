#!/bin/sh
PROJECT=$1
gcloud auth login
gcloud config set project "${PROJECT}"
gcloud beta container --project "${PROJECT}" clusters create "awx-cluster" \
    --zone "asia-southeast1-a" \
    --no-enable-basic-auth \
    --cluster-version "1.19.9-gke.1900" \
    --machine-type "e2-standard-2" \
    --image-type "COS_CONTAINERD" \
    --disk-type "pd-standard" \
    --disk-size "100" \
    --metadata disable-legacy-endpoints=true \
    --scopes "default,logging-write,monitoring,service-control,service-management,trace" \
    --num-nodes "3" \
    --enable-stackdriver-kubernetes \
    --enable-ip-alias \
    --network "projects/${PROJECT}/global/networks/default" \
    --subnetwork "projects/${PROJECT}/regions/asia-southeast1/subnetworks/default" \
    --no-enable-intra-node-visibility \
    --default-max-pods-per-node "110" \
    --no-enable-master-authorized-networks \
    --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver \
    --no-enable-autoupgrade \
    --enable-autorepair \
    --max-surge-upgrade 1 \
    --max-unavailable-upgrade 0 \
    --enable-shielded-nodes \
    --node-locations "asia-southeast1-a"