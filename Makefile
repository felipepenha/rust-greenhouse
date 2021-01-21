BUILD = docker-compose build
RUN = docker-compose run


help:
	@echo "USAGE"
	@echo
	@echo "    make <command>"
	@echo "    Include 'sudo' when necessary."
	@echo
	@echo
	@echo "COMMANDS"
	@echo
	@echo "    build:           build image using cache"
	@echo "    build-no-cache:  build image from scratch, and not from cache"
	@echo "    bash:            bash REPL (Read-Eval-Print loop), suitable for debugging"
	@echo "    rust:            access rust through the Evcxr REPL (Read-Eval-Print loop)"
	@echo "    rust-jupyter:    access rust through the Evcxr Jupyter Notebook"

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

rust-jupyter:
	$(RUN) --service-ports rust-jupyter

