SHELL := /bin/bash
BIN_DIR := $(HOME)/.local/bin
IMAGE_BUILD_OPTS :=

-include config.local.mk

.PHONY: image/%
image/%:	
	podman build $(IMAGE_BUILD_OPTS) $(IMAGE_BUILD_OPTS_$*) \
	-t localhost/podman-workspace:$* \
	images/$*

.PHONY: image/runtime/%
image/runtime/%:	
	podman build $(IMAGE_BUILD_OPTS) $(IMAGE_BUILD_OPTS_$*) \
	--build-arg=RUNTIME=$* \
	-t localhost/podman-workspace:runtime-$* \
	images/runtime

.PHONY: install
install:
	install -D -m 755 src/podman-workspace  $(BIN_DIR)/podman-workspace
