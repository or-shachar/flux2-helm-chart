#!/bin/bash

RELEASE=flux2
NAMESPACE=flux-system

function fix {
    KIND=$1
    NAME=$2
    kubectl annotate $KIND $NAME -n $NAMESPACE meta.helm.sh/release-name=$RELEASE
    kubectl annotate $KIND $NAME -n $NAMESPACE meta.helm.sh/release-namespace=$NAMESPACE
    kubectl label $KIND -n $NAMESPACE $NAME app.kubernetes.io/managed-by=Helm
}

fix ServiceAccount helm-controller
fix ServiceAccount kustomize-controller
fix ServiceAccount notification-controller
fix ServiceAccount source-controller
fix ClusterRole crd-controller-flux-system
fix ClusterRoleBinding cluster-reconciler-flux-system
fix ClusterRoleBinding crd-controller-flux-system
fix Service notification-controller
fix Service webhook-receiver

fix Deployment notification-controller
fix Deployment helm-controller
fix Deployment kustomize-controller
fix Deployment source-controller

helm install --dry-run flux2 -n flux-system .