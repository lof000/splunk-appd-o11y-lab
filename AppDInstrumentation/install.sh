kubectl create ns appdynamics

helm install -f ./values-ca1.yaml "caagent" appdynamics-cloud-helmcharts/cluster-agent --namespace=appdynamics

