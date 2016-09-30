#
# Shortcuts to common Gitbook commands
#

# Container meta-info
BIN := gitbook
REGISTRY ?= spohnan
IMAGE := $(REGISTRY)/$(BIN)
CONTAINER := $(REGISTRY)-$(BIN)

# The base command to run the Gitbook container
RUN_CMD := @docker run          \
        -p 4000:4000 --rm       \
	    -v $$(pwd):/srv/gitbook \
	    --name "$(CONTAINER)"   \
	    $(IMAGE) $(BIN)

# No target argument passed
nomatch:
	@echo "Usage: make [buildimage|build|clean|init|pdf|serve]"

# Rebuild the docker container
# Must be run from the directory containing the Dockerfile
buildimage:
	docker build -t $(IMAGE) .

# --- Gitbook Actions

build:
	$(RUN_CMD) build
	$(RUN_CMD) pdf . ./_book/book.pdf

clean:
	@rm -fr _book

init: stop
	$(RUN_CMD) init

pdf:
	@mkdir -p _book
	$(RUN_CMD) pdf . ./_book/book.pdf

serve:
	$(RUN_CMD) serve > /dev/null 2>&1 &

status:
	@docker ps --filter="name=$(CONTAINER)"

stop:
	@docker kill $(shell docker ps --filter=\"name=$(CONTAINER)\" -q) > /dev/null 2>&1 || true
