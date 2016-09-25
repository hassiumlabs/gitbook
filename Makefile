BIN := gitbook

REGISTRY ?= spohnan

IMAGE := $(REGISTRY)/$(BIN)

RUN_CMD := @docker run \
	    -v $$(pwd):/srv/gitbook \
	    $(IMAGE) $(BIN)

all:
	$(RUN_CMD) --help

build:
	$(RUN_CMD) build
	$(RUN_CMD) pdf . ./_book/book.pdf

clean:
	@rm -fr _book

init:
	$(RUN_CMD) init

pdf:
	@mkdir -p _book
	$(RUN_CMD) pdf . ./_book/book.pdf 

serve: 
	$(RUN_CMD) -p 4000:4000 serve
