# VERSIONS
PLAYWRIGHT_VERSION ?= 1.49.0
NODEJS_VERSION ?= 20.18.1

CONTAINER_MANAGER ?= podman
MANIFEST ?= quay.io/devtools-qe/pwt

.PHONY: build 

build:
	${CONTAINER_MANAGER} build -t $(MANIFEST):$(OS)-$(ARCH) \
		--target $(OS) -f Containerfile \
		--build-arg=OS=$(OS) --build-arg=ARCH=$(ARCH) \
		--build-arg=NODEJS_VERSION=$(NODEJS_VERSION) .

