kubectl create ns splunk-appd

helm install -f ./values-ca1.yaml "caagent" appdynamics-cloud-helmcharts/cluster-agent --namespace=splunk-appd

# to list available versions
# helm search repo appdynamics-cloud-helmcharts --versions

#use specific version
#helm install -f ./values-ca1.yaml "caagent" appdynamics-cloud-helmcharts/cluster-agent --version 1.31.1205  --namespace=splunk-appd 


#1.33.1447
