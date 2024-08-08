
# Ubuntu 22.04 based MLflow image v2.15.1
[![On pull request](https://github.com/canonical/base-mlflow/actions/workflows/on_pull_request.yaml/badge.svg)](https://github.com/canonical/base-mlflow/actions/workflows/on_pull_request.yaml)
[![On push](https://github.com/canonical/base-mlflow/actions/workflows/on_push.yaml/badge.svg)](https://github.com/canonical/base-mlflow/actions/workflows/on_push.yaml)

This repository contains source code for Canonical's MLFlow rock image.

The rock image is currently published [here](https://hub.docker.com/r/charmedkubeflow/mlflow).

# MLflow rock OCI image

The following tools are required to build the rock image manually:
- `rockcraft` - A tool to create OCI images.
- `skopeo` - A tool to operate on container images and registries.
- `tox` - A tool to run tests in virtual environments. The tool is a Python package, so a Python interpreter with the `pip` package tool is needed (tested with python3.10, python3.8).

To install the tools:
```bash
sudo snap install rockcraft --classic --edge
sudo snap install skopeo --edge --devmode
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
```

To test the resulting image after copying to Docker, run it:
```bash
# Create a local folder to be mounted to the container 
mkdir mlruns
# Change permissions on the folder
chmod 777 mlruns 

# Run the server with the mounted folder 
docker run -p 5000:5000 -v ./mlruns:/mlruns --entrypoint=mlflow mlflow:v2.15.1 server --host 0.0.0.0 --backend-store-uri file:///mlruns
```

Then you can visit [http://localhost:5000/](http://localhost:5000/).