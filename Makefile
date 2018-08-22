# These are the usual GKE variables.
PROJECT       ?= cpe-performance-storage
ZONE          ?= us-east1-b
CLUSTER       ?= prow

.PHONY: update-config
update-config: get-cluster-credentials
	kubectl create configmap config --from-file=config.yaml=config.yaml --dry-run -o yaml | kubectl replace configmap config -f -

.PHONY: update-cluster
update-cluster: get-cluster-credentials
	kubectl apply -f starter.yaml

.PHONY: update-plugins
update-plugins: get-cluster-credentials
	kubectl apply -f plugins.yaml

.PHONY: get-cluster-credentials
get-cluster-credentials:
	gcloud container clusters get-credentials "$(CLUSTER)" --project="$(PROJECT)" --zone="$(ZONE)"
