
# MLflow image
[![On pull request](https://github.com/canonical/base-mlflow/actions/workflows/on_pull_request.yaml/badge.svg)](https://github.com/canonical/base-mlflow/actions/workflows/on_pull_request.yaml)
[![On push](https://github.com/canonical/base-mlflow/actions/workflows/on_push.yaml/badge.svg)](https://github.com/canonical/base-mlflow/actions/workflows/on_push.yaml)

This repository contains source code for Canonical's MLFlow rock image.

The rock image is currently published [here](https://hub.docker.com/r/charmedkubeflow/mlflow).

# MLflow rock OCI image

The following tools are required to build and test the rock image:
- `rockcraft` - A tool to create OCI images.
- `yq` - Command-line YAML processor.
- `tox` - A tool to create and set up environments to run commands in them.

To install the tools:
```bash
sudo snap install rockcraft --classic
sudo snap install yq
pip install tox
```

To build the rock image manually:
```bash
cd mlflow 
tox -e pack
```

To use the resulting rock in Docker:
```bash
tox -e export-to-docker
# Find the proper tag of your image
docker images
```

To test the resulting image after copying to Docker, run it:
```bash
# Create a local folder to be mounted to the container 
mkdir mlruns
# Change permissions on the folder
chmod 777 mlruns 

# Run the server with the mounted folder 
docker run -p 5000:5000 -v ./mlruns:/mlruns --entrypoint=mlflow mlflow:<tag> --host 0.0.0.0 --backend-store-uri file:///mlruns
```

Then you can visit [http://localhost:5000/](http://localhost:5000/) to access the main MLflow dashboard.
