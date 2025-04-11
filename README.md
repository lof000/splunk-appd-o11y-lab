# DigiBank Sample Application

This repository contains sample code to simulate an application that traverses n-tier and microservices architectures, designed for demonstrating observability and monitoring.

## Overview

**DigiBank** is a sample application with the following components:
- **Namespaces `digibank` and `digibank-backends`**: Simulate an n-tier application using Java and Node.js with MySQL.
- **Namespace `visa-backends`**: Simulates microservices using Java and Redis.

![Architecture Diagram](/img/digibank.png)

## Requirements

To run this application, ensure you have:
- A running Kubernetes (k8s) cluster
- `kubectl` installed and configured
- Helm installed
- Access to an AppDynamics controller
- Access to Splunk Observability Cloud

## Installation and Running

Follow these steps to deploy and run the DigiBank application:

### 1. Deploy the Application

Navigate to the `app/digibank` folder and run:

```bash
helm install digibank .
```

### 2. Deploy AppDynamics Cluster Agent

In the `AppDInstrumentation` folder:
- Edit `values-ca1.yaml` to configure:
    - your controller connection in the `controllerInfo:` section.
    - your application name in the `instrumentationConfig:`
- Install the cluster agent:

```bash
./init.sh
./install.sh
```

##### cluster agent will do auto-instrumentation

### 3. Deploy Splunk OTel Collector

In the `o11yInstrumentation` folder, run:

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

### 4. Instrument Microservices with Splunk OTel Agent

In the `o11yInstrumentation` folder, run:

```bash
./instrument_code.sh
```

### 5. Generate Load

In the `app/digibank-load` folder, run:

```bash
helm install digibank-load .
```

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