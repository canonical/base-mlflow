
# Ubuntu 22.04 based MLflow image v2.15.0
This repository regularly builds a new [MLflow](https://github.com/mlflow/mlflow) image based on LTS Ubuntu 22.04. After the new image is built, the CI runs simple tests against the image and runs the [trivy](https://github.com/aquasecurity/trivy) vulnerability scan. 

The image is currently published [here](https://hub.docker.com/r/charmedkubeflow/mlflow)
You can use this image seamlessly as any other Python Docker image by specifying it as a base with:

```dockerfile
FROM charmedkubeflow/mlflow:latest
```

# MLflow ROCK OCI image

The following tools are required to build the ROCK image manually:
- `rockcraft` - A tool to create OCI images.
- `skopeo` - A tool to operate on container images and registries.

To install tools:
```bash
sudo snap install rockcraft --classic --edge
sudo snap install skopeo --edge --devmode
```

To build the ROCK image manually:
```bash
rockcraft pack
```

To copy the resulting image `base-mlflow_v2.15.0_amd64.rock` to Docker:
```bash
sudo skopeo --insecure-policy copy oci-archive:base-mlflow_v2.15.0_amd64.rock docker-daemon:base-mlflow_v2.15.0_amd64.rock:rock
```

To test the resulting image after copying to Docker using `skopeo`, run it:
```bash
docker run -p 5000:5000 --entrypoint=mlflow base-mlflow_v2.15.0_amd64.rock:rock server --host 0.0.0.0
```

Then you can visit http://localhost:5000/