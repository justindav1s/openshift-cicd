#!/usr/bin/env bash


. ./env.sh

oc login https://${IP}:8443 -u $USER

oc delete project $CICD_PROJECT
oc new-project $CICD_PROJECT 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
    oc new-project $CICD_PROJECT 2> /dev/null
done

echo run "oc edit namespace $CICD_PROJECT"
echo add "openshift.io/node-selector: “region=infra"
echo to target CICD resources at infra nodes
