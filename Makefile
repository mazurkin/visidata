SHELL := /bin/bash
ROOT  := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PYTHON_VERSION    = 3.12.15
POETRY_VERSION    = 2.5.1

CONDA_ENV_NAME    = visidata

# -----------------------------------------------------------------------------
# defaults
# -----------------------------------------------------------------------------

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

.PHONY: env-create
env-create:
	@conda create --yes --copy --name "$(CONDA_ENV_NAME)" \
		conda-forge::python=$(PYTHON_VERSION) \
		conda-forge::poetry=$(POETRY_VERSION)

.PHONY: env-poetry-install
env-poetry-install:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" \
		poetry install \
          	--no-interaction \
          	--no-ansi \
          	--no-root \
			--no-directory

.PHONY: env-poetry-update
env-poetry-update:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" \
		poetry update

.PHONY: env-remove
env-remove:
	@conda env remove --name "$(CONDA_ENV_NAME)" --yes

.PHONY: env-shell
env-shell:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" \
		bash

.PHONY: env-info
env-info:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" \
		conda info

.PHONY: env-list
env-list:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" \
		conda list
