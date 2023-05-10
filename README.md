# Ubuntu 22.04 based MLflow image v2.1.1
This repository regularly builds new [Mlflow](https://github.com/mlflow/mlflow) image base on LTS Ubuntu 22.04. The process weekly downloads the upstream MLflow v2.1.1 and changes the base for Docker image with the Dockerfile you can see in this repository. After the new image is built the ci runs simple tests against the image and runs the [trivy](https://github.com/aquasecurity/trivy) vulnerability scan. The results are published to the security tab in the repository (only visible to admins). 

The image is currently published [here](https://hub.docker.com/r/charmed/base-mlflow)
You can use this image seamlesly as any other python Docker image by specifying it as a base with.

```
FROM charmed/base-mlflow:latest
```

# MLflow ROCK OCI image

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
docker run -p 5000:5000 --entrypoint=mlflow base-mflow_v2.1.1_amd64.rock:rock server --host 0.0.0.0
```

Then you can visit the http://localhost:5000/