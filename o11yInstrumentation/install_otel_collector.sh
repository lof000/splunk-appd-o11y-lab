#!/bin/bash

if [ -z "$1" ]
then
      echo "please inform ingestion token"
      exit 1
fi


CLUSTER="digibank_k8s_cluster"
REALM="us1"
S_ENVIRONMENT="digibank_lab"

kubectl create ns splunk-o11y
helm install splunk-otel-collector -n splunk-o11y --set="cloudProvider=aws,distribution=eks,splunkObservability.accessToken=$1,clusterName=$CLUSTER,splunkObservability.realm=$REALM,gateway.enabled=false,splunkObservability.profilingEnabled=true,environment=$S_ENVIRONMENT,operatorcrds.install=true,operator.enabled=true,agent.discovery.enabled=true" splunk-otel-collector-chart/splunk-otel-collector

#helm install splunk-otel-collector --version 0.132.0 -n splunk-o11y --set="cloudProvider=aws,distribution=eks,splunkObservability.accessToken=$1,clusterName=$CLUSTER,splunkObservability.realm=$REALM,gateway.enabled=false,splunkObservability.profilingEnabled=true,environment=$S_ENVIRONMENT,operatorcrds.install=true,operator.enabled=true,agent.discovery.enabled=true" splunk-otel-collector-chart/splunk-otel-collector


