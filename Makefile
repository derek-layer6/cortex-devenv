SHELL=/bin/bash -o pipefail

PORT=8501

.PHONY: help
help:
	@echo 'Targets:'
	@echo '    build            Build and install docker container.'

.PHONY: build
build:
	docker build -t cortex-development .


.PHONY: install
install:
	sudo cp develop /usr/local/bin/
