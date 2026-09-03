SHELL := /bin/bash
BIN_DIR := $(HOME)/.local/bin
IMAGE_BUILD_OPTS :=


.PHONY: image/%
image/%:
	podman build \
	$(IMAGE_BUILD_OPTS) \
	--build-arg=USERNAME=$(shell id -un) \
	--build-arg=UID=$(shell id -u) \
	--build-arg=GID=$(shell id -g) \
	-t localhost/podman-workspace:$* \
	images/$*

.PHONY: install
install:
	install -D -m 755 src/podman-workspace  $(BIN_DIR)/podman-workspace
