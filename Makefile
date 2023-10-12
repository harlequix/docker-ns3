
ifneq ("$(wildcard .env)","")
  include .env
endif

VERSIONS := 3.36 3.37 3.38 3.39 3.40
LATEST := 3.40
VERSION ?= $(LATEST)
APPLICATION := ns

help:
	@echo "Usage: make [TARGET]"
	@echo ""
	@echo "Targets:"
	@echo "  build: build a specific version"
	@echo "  latest: build latest version"
	@echo "  push: push to registry"
	@echo "  all: build all versions"
	@echo "  help: show this help"

latest:
	@$(MAKE) build VERSION=$(LATEST)
	docker tag $(APPLICATION):$(LATEST) $(APPLICATION):latest

build: 
	docker build -t $(APPLICATION):$(VERSION) --build-arg Version=$(VERSION) .

push: build
	docker tag $(APPLICATION):$(VERSION) $(DOCKER_REGISTRY)/$(APPLICATION):$(VERSION)
	docker push $(DOCKER_REGISTRY)/$(APPLICATION):$(VERSION)