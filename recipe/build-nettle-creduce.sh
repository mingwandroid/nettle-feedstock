#!/usr/bin/env bash

conda-build ~/conda/nettle-feedstock/recipe -m ~/conda/aggregate/conda_build_config.yaml --croot=${PWD} --no-build-id > /dev/null 2>&1 || true
conda-build ~/conda/gnutls-feedstock/recipe -m ~/conda/aggregate/conda_build_config.yaml --croot=${PWD} --no-build-id > /dev/null 2>&1 || exit 0

exit 1
