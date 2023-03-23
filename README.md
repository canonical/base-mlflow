# Ubuntu 22.04 based MLflow image v2.1.1

This repository regularly builds new [Mlflow](https://github.com/mlflow/mlflow) image base on LTS Ubuntu 22.04. The process weekly downloads the upstream MLflow v2.1.1 and performs two images builds:
- Docker image with changed the base using `Dockerfile`
<!-- - ROCK image using `rockcraft.yaml` -->

After the new images are built the CI runs simple tests against the images and runs the [trivy](https://github.com/aquasecurity/trivy) vulnerability scan. The results are published to the security tab in the repository (only visible to admins). 

## Docker image

Docker image is currently published [here](https://hub.docker.com/r/charmed/base-mlflow)
You can use this image seamlesly as any other python Docker image by specifying it as a base with.

```
FROM charmed/base-mlflow:latest
```

Refer to `.github/workflows/build_and_publish_call.yaml` for details on how to build Docker image manually.


## ROCK image

<!-- ROCK image is currently published [here](https://ghcr.io/canonical) -->


The following tools are required to build ROCK image manually:
- `rockcraft' - A tool to create OCI images.
- `skopeo` - A tool to operate on container images and registries.

To install tools:
```
sudo snap install rockcraft --classic --edge
sudo snap install skopeo --edge --devmode
```

To build ROCK image manually:
```
rockcraft pack
```

To copy resulting image `base-mflow_v2.1.1_amd64.rock` to Docker:
```
sudo skopeo --insecure-policy copy oci-archive:base-mflow_v2.1.1_amd64.rock docker-daemon:base-mflow_v2.1.1_amd64.rock:rock
```

To test resulting image after copying to Docker using `skopeo`, run it:

```
 docker run -p 5000:5000 base-mflow_v2.1.1_amd64.rock:rock
```

Then navigate to `http://localhost:5000/`. MLflow UI should be displayed.

