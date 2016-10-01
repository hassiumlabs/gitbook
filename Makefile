#
# Shortcuts to common Gitbook commands
#

# Container meta-info
BIN := gitbook
REGISTRY ?= spohnan
IMAGE := $(REGISTRY)/$(BIN)
CONTAINER := $(REGISTRY)-$(BIN)

# The base command to run the Gitbook container
RUN_CMD := @docker run --rm -v $$(pwd):/srv/gitbook $(IMAGE)

GITBOOK_CMD := $(RUN_CMD) $(BIN)

# Slightly different options and a name so we can kill easily
SERVE_CMD := @docker run               \
               -p 4000:4000 --rm       \
               -v $$(pwd):/srv/gitbook \
               --name "$(CONTAINER)"   \
               $(IMAGE) $(BIN)

# No target argument passed
nomatch:
	@echo "Usage: make [buildimage|build|clean|init|pdf|serve|status|stop|themeinit|themebuild]"

# Rebuild the docker container
# Must be run from the directory containing the Dockerfile
buildimage:
	@docker build -t $(IMAGE) .

# --- Gitbook Actions

build:
	$(GITBOOK_CMD) build
	$(GITBOOK_CMD) pdf . ./_book/book.pdf

clean:
	@rm -fr _book

init: stop
	$(GITBOOK_CMD) init

pdf:
	@mkdir -p _book
	$(GITBOOK_CMD) pdf . ./_book/book.pdf

serve:
	$(SERVE_CMD) serve > /dev/null 2>&1 &

status:
	@docker ps --filter="name=$(CONTAINER)"

stop:
	@docker kill $(shell docker ps --filter=\"name=$(CONTAINER)\" -q) > /dev/null 2>&1 || true

# --- Gitbook Theme Actions
# For use with themes such as https://github.com/GitbookIO/theme-default

themeinit:
	$(RUN_CMD) npm update

themebuild:
	$(RUN_CMD) ./src/build.sh
