#!/bin/bash
#create secret for ops-manager api access
oc create secret generic om-medhat-credentials  \
--from-literal="user=mabounar@eg.ibm.com" \
--from-literal="publicApiKey=b182a99b-72c1-4d6c-9437-5962c12bf565"  -n mongodb
#get opsmanager endpoint url

OPSMANAGER_URL="$(oc get om ops-manager -o jsonpath='{.status.opsManager.url}')"
oc create configmap ops-manager-connection  \
--from-literal="$OPSMANAGER_URL"  -n mongodb

#create mongodb 
oc apply -f replica-set.yaml
