# sorry-cypress-run-cleaner
A lightweight container that removes old test runs from Sorry-Cypress. Note: This does not delete anything stored in S3 buckets (or minio etc), you should configure your S3 lifecycle rules to delete objects once expired.

The container is designed to be run regularly in cloud native workflows (eg [Argo Workflows](https://argoproj.github.io/argo-workflows/), or [Tekton](https://tekton.dev/)), but will run wherever a container can be run.

![CI](https://github.com/sendible-labs/sorry-cypress-run-cleaner/actions/workflows/ci.yaml/badge.svg) ![Release](https://github.com/sendible-labs/sorry-cypress-run-cleaner/actions/workflows/release.yaml/badge.svg)
