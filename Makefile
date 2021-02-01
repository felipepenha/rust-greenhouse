BUILD = docker-compose build
RUN = docker-compose run

VERSION = $(shell awk -F ' = ' '$$1 ~ /version/ { gsub(/[\"]/, "", $$2); printf("%s",$$2) }' Cargo.toml)

help:
	@echo "USAGE"
	@echo
	@echo "    make <command>"
	@echo "    Include 'sudo' when necessary."
	@echo
	@echo
	@echo "COMMANDS"
	@echo
	@echo "    build           build image using cache"
	@echo "    build-no-cache  build image from scratch, and not from cache"
	@echo "    bash            bash REPL (Read-Eval-Print loop), suitable for debugging"
	@echo "    rust            access rust through the Evcxr REPL (Read-Eval-Print loop)"
	@echo "    jupyter    access rust through the Evcxr Jupyter Notebook"
	@echo "    release         Release VERSION (specified in Cargo.toml) on the dev branch"

#################
# User Commands #
#################

build:
	$(BUILD)

build-no-cache:
	$(BUILD) --no-cache

bash:
	$(RUN) bash

rust:
	$(RUN) rust

jupyter:
	$(RUN) --service-ports jupyter
	
release:
	git tag -a $(VERSION) -m "Auto-generated release $(VERSION)"
	git push origin dev tag $(VERSION)
