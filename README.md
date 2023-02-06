# Ubuntu 22.04 based Mlflow image v2.1.1
This repository regularly builds new [Mlflow](https://github.com/mlflow/mlflow) image base on LTS Ubuntu 22.04. The process weekly downloads the upstream Mlflow v2.1.1 and changes the base for Docker image with the Dockerfile you can see in this repository. After the new image is built the ci runs simple tests against the image and runs the [trivy](https://github.com/aquasecurity/trivy) vulnerability scan. The results are published to the security tab in the repository (only visible to admins). 

The image is currently published [here](https://hub.docker.com/r/charmed/base-mlflow)
You can use this image seamlesly as any other python Docker image by specifying it as a base with.

```
FROM charmed/base-mlflow:latest
```