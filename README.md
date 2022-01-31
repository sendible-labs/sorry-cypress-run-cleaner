# sorry-cypress-run-cleaner
A lightweight container that removes old test runs from the Sorry Cypress database via the Sorry Cypress API.

**Note: This does not delete anything stored in S3 buckets (or minio etc), you should configure your S3 lifecycle rules to delete objects once expired.**

The container is designed to be run regularly in cloud native workflows (eg [Argo Workflows](https://argoproj.github.io/argo-workflows/), or [Tekton](https://tekton.dev/)), but will run wherever a container can be run.

![CI](https://github.com/sendible-labs/sorry-cypress-run-cleaner/actions/workflows/ci.yaml/badge.svg) ![Release](https://github.com/sendible-labs/sorry-cypress-run-cleaner/actions/workflows/release.yaml/badge.svg)

# Environment Variables
We pass key information to the container using environment variables.
| Environment Variable  | Type      | Description                                                                                                                                       |
|---------------------- |---------- |-------------------------------------------------------------------------------------------------------------------------------------------------- |
| `sorry_cypress_api_url`               | string    | [required] The url of your sorry-cypress API endpoint. Include `http://` or `https://` where appropriate. If you are running this container within the same cluster as Sorry Cypress (e.g. using Argo Workflows), we strongly suggest you use the internal dns entry for the endpoint to avoid hairpinning. For example `http://api-sorry-cypress.sorry-cypress.svc.cluster.local`
| `run_days_to_keep`               | int    | The number of days to keep Sorry Cypress runs before cleaning them. If omitted, defaults to 100 days.

# Docker run example
This example with run against our defined API and keep the last 200 days of Sorry Cypress test runs.
```
docker run \
-e sorry_cypress_api_url='https://api.sorry-cypress.sendible.com' \
-e run_days_to_keep='200' \
ghcr.io/sendible-labs/sorry-cypress-run-cleaner:stable
```

# Crontab Docker example
To execute as a linux cron, wrap your docker run command in a simple shell script and then call the script at the desired interval.
```
0 22 * * WED /path/to/script.sh
```

# Kubernetes cronjob example
[Kubernetes Cronjob Example](https://github.com/sendible-labs/sorry-cypress-run-cleaner/tree/main/examples/argo-workflows)

# Argo Workflows examples
[Workflow Examples](https://github.com/sendible-labs/sorry-cypress-run-cleaner/blob/main/examples/kubernetes/k8s-cron.yaml)

We have provided an example workflowTemplate. Deploy this to your cluster in an appropriate namespace for your setup. You can manually trigger this in the usual ways.

If you wish to have it run regularly, the example cronWorkflow will call the workflow template at the defined cron intervals.
