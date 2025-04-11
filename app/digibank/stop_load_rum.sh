
kubectl patch cronjobs play -n digibank -p '{"spec" : {"suspend" : true }}'

#!/bin/bash

# Set your namespace here
NAMESPACE="digibank"

# Get all jobs with active pods (i.e., still running) and delete them
echo "Deleting all running jobs in namespace: $NAMESPACE"

kubectl get jobs -n "$NAMESPACE" --no-headers | awk '$3 > 0 {print $1}' | while read job; do
  echo "Deleting job: $job"
  kubectl delete job "$job" -n "$NAMESPACE"
done

echo "Done."
