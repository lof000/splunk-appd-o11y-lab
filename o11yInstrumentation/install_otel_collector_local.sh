

kubectl create ns splunk-o11y
helm install splunk-otel-collector -n splunk-o11y --set="splunkObservability.accessToken=oeHSPfE2bUgGaIazsL7sTg,clusterName=digibank-k8s-docker,splunkObservability.realm=us1,gateway.enabled=false,splunkObservability.profilingEnabled=true,environment=digibank_lab,operatorcrds.install=true,operator.enabled=true,agent.discovery.enabled=true" splunk-otel-collector-chart/splunk-otel-collector
