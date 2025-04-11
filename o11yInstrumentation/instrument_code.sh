

kubectl patch deployment visa-java-backend-redis -n visa-backends -p '{"spec":{"template":{"metadata":{"annotations":{"instrumentation.opentelemetry.io/inject-java":"o11y/splunk-otel-collector"}}}}}'



