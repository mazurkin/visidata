SHELL := /bin/bash
ROOT  := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

CONDA_ENV_NAME = visidata

.DEFAULT_GOAL = info

# -----------------------------------------------------------------------------
# welcome
# -----------------------------------------------------------------------------

.PHONY: info
info:
	@echo "visidata: $(ROOT)"

# -----------------------------------------------------------------------------
# conda environment
# -----------------------------------------------------------------------------

.PHONY: env-init
env-init:
	@conda create --yes --copy --name "$(CONDA_ENV_NAME)" \
		python=3.12.12 \
		conda-forge::poetry=2.2.1

.PHONY: env-create
env-create:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" poetry install --no-root

.PHONY: env-update
env-update:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" poetry update

.PHONY: env-remove
env-remove:
	@conda env remove --name "$(CONDA_ENV_NAME)" --yes

.PHONY: env-shell
env-shell:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" bash

.PHONY: env-info
env-info:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" conda info

.PHONY: env-list
env-list:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" conda list
