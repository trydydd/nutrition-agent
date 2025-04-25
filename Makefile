SHELL := /bin/bash

# Variables
VENV_DIR := venv
PYTHON := python3

.PHONY: all setup deploy download-models create-venv install-requirements clean

all: setup

setup: download-models create-venv install-requirements

deploy: download-models create-venv install-requirements run-model

# Download models using ollama
download-models:
	ollama pull llama3.2:1b
	ollama pull mxbai-embed-large

# Create Python virtual environment
create-venv:
	$(PYTHON) -m venv $(VENV_DIR)

# Install Python requirements inside virtual environment
install-requirements:
	. $(VENV_DIR)/bin/activate && pip install --upgrade pip && pip install -r requirements.txt

# Run the model
run-model:
	source ./venv/bin/activate; \
	python3 main.py

# Clean up virtual environment (optional)
clean:
	rm -rf $(VENV_DIR)
	ollama rm llama3.2:1b
	ollama rm mxbai-embed-large
