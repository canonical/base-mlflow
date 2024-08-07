# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

import pytest
import subprocess

from charmed_kubeflow_chisme.rock import CheckRock


@pytest.mark.abort_on_fail
def test_rock():
    """Test rock."""
    check_rock = CheckRock("rockcraft.yaml")
    rock_image = check_rock.get_name()
    rock_version = check_rock.get_version()
    LOCAL_ROCK_IMAGE = f"{rock_image}:{rock_version}"

    # assert we have expected mlflow library installed
    result = subprocess.run(
        [
            "docker",
            "run",
            "--entrypoint",
            "/bin/bash",
            LOCAL_ROCK_IMAGE,
            "-c",
            "pip list | grep -E '^mlflow\\s+2\\.15\\.[0-9]+$'"
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        check=True,
    )
    
    # Check if the grep command found the desired package version
    assert "mlflow" in result.stdout, "mlflow version 2.15.x is not installed"
