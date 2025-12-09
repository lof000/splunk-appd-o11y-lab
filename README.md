# DigiBank Sample Application

This repository contains sample code to simulate an application that traverses n-tier and microservices architectures, designed for demonstrating observability and monitoring.

## Overview

**DigiBank** is a sample application with the following components:
- **Namespaces `digibank` and `digibank-backends`**: Simulate an n-tier application using Java and Node.js with MySQL. AppDynamics java agents in dual mode sending traces to AppDynamics and Splunk OTel Collector
- **Namespace `visa-backends`**: Simulates microservices using Java and Redis. Splunk java agent.
- **Namespace `splunk-appd`**: Splunk AppDynamics Cluster Agent
- **Namespace `splunk-o11y`**: Splunk OTel Collector/Operator 

![Architecture Diagram](/img/digibank.png)

## Requirements

To run this application, ensure you have:
- A running Kubernetes (k8s) cluster - tested with EKS 1.32 and docker desktop kubernetes
- `kubectl` installed and configured
- Helm 3.19
- Access to an AppDynamics controller
- Access to Splunk Observability Cloud

## Installation and Running

Follow these steps to deploy and run the DigiBank application:

### 1. Deploy the Application

Navigate to the `app/digibank` folder and run:

```bash
helm install digibank .
```

### 2. Deploy Splunk OTel Collector

In the `o11yInstrumentation` folder:

- Edit `install_otel_collector.sh` and fill out your information

```bash
CLUSTER="<your_cluster_name>"
REALM="<SPLUNK_REALM>"
S_ENVIRONMENT="<ENVIRONMENT>"
```

- Then run:

```bash
./init.sh
./install_otel_collector.sh <your_ingestion_token>
```

Replace `<your_ingestion_token>` with your Splunk Observability Cloud ingestion token.

- Validate
```bash
kubectl get pods -n splunk-o11y

splunk-otel-collector-agent-2f4b2                             (one per node)     Running   
splunk-otel-collector-k8s-cluster-receiver-7c9bf8c6c5-pfl4k   1/1     Running
splunk-otel-collector-operator-67ff5f79b8-jjq27               2/2     Running   

```

[Install the Collector using Helm](https://help.splunk.com/en/splunk-observability-cloud/manage-data/splunk-distribution-of-the-opentelemetry-collector/get-started-with-the-splunk-distribution-of-the-opentelemetry-collector/collector-for-kubernetes/install-with-helm)


### 3. Instrument Microservices with Splunk OTel Agent

In the `o11yInstrumentation` folder, run:

```bash
./instrument_code.sh
```
- Validate

wait a few minutes and run

```bash
kubectl describe pod visa-java-backend-redis-77446b8f67-x6g2j -n visa-backends|grep Image:

    Image:         ghcr.io/signalfx/splunk-otel-java/splunk-otel-java:v2.20.1
    Image:          leandrovo/digitalbank-backend-java-redis:1.0

```


### 4. Deploy Splunk AppDynamics Cluster Agent

In the `AppDInstrumentation` folder:
- Rename `values-ca1-example.yaml` to `values-ca1.yaml`
- Edit `values-ca1.yaml` to configure:
    - your controller connection in the `controllerInfo:` section.
    - your application name in the `instrumentationConfig:`
- Install the cluster agent:

```bash
./init.sh
./install.sh
```

- Validate

```bash
kubectl get pods -n splunk-appd

NAME                                                             READY   
appdynamics-operator-576cbdc454-87rhm                            1/1    
caagent-appdynamics-cluster-agent-splunk-appd-77f957c6bc-646jv   1/1    

```
##### Reference doc.

[Install the Cluster Agent with Helm Charts](https://help.splunk.com/en/appdynamics-saas/infrastructure-visibility/25.10.0/monitor-kubernetes-with-the-cluster-agent/installation-overview/install-the-cluster-agent-with-helm-charts)


[Auto-Instrument Applications with the Cluster Agent](https://help.splunk.com/en/appdynamics-saas/infrastructure-visibility/25.10.0/monitor-kubernetes-with-the-cluster-agent/auto-instrument-applications-with-the-cluster-agent)


>>> indicar onde alteraou?? resouece attibs.. variavel de ambietn para ativar o agente..

##### cluster agent will do auto-instrumentation


- The Splunk AppDynamics operator will attach the AppDynamics dual agent according to what is defined in the values-ca1.yaml file. After 5 minutes you can run the below command and validate.

```bash
kubectl describe pod digital-bank-front-f875775bf-92lwv -n digibank|grep Image: 

    Image:         docker.io/appdynamics/java-agent:latest
    Image:          leandrovo/digitalbank-new:3.0
```

### 5. Generate Load

In the `app/digibank-load` folder, run:

```bash
helm install digibank-load .
```

- wait about 5 minutes

### 6. Verify Deployment

Check if everything is running correctly 

- inspecting the Kubernetes running pods
- in splunk o11y filter by Envionment:`<your environment>`
- in AppD find applicatios called `<your application>>` 

## Notes

- Ensure all prerequisites are met before starting the deployment.
- The Nginx snippet mentioned in the original instructions has been removed for testing purposes.

## License

This project is licensed under the [MIT License](LICENSE).


This README.md file organizes the provided instructions into a clear, concise format suitable for a GitHub repository, with sections for overview, requirements, installation steps, and additional notes. Replace `<insert_picture_path_here>` with the actual path to the architecture diagram image if available.