.PHONY: all build install help

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: build install ## Compile and install

build: ## Compile a binary
	@crystal build src/main.cr --release -o mixcloud_playlist

install: ## Install compiled bin to ~/bin
	@mv mixcloud_playlist ~/bin/
