.DEFAULT_GOAL := help

COMPOSE = docker-compose -f docker-compose.yml -f docker-compose.override.yml

.PHONY: setup
setup:  ## setup project
	@mkdir -p priv/plts
	@mix do local.rebar --force, local.hex --force
	@mix do deps.get, deps.compile
	@mix dialyzer --plt

.PHONY: check_format
check_format:  ## run format checker
	@mix format --check-formatted

.PHONY: credo
credo:  ## run credo
	@mix credo suggest --strict --format=flycheck

.PHONY: dialyzer
dialyzer:  ## run dialyzer
	@mix dialyzer --no-check --quiet --ignore-exit-status --format short

.PHONY: static_code_analysis
static_code_analysis: check_format credo dialyzer  ## run static code analysis

.PHONY: test
test:  ## run tests
	@mix test --cover --trace --slowest 10

.PHONY: compose_up
compose_up:  ## start containers for this service
	@$(COMPOSE) up -d

.PHONY: compose_test
compose_test:  ## run tests in containers
	@$(COMPOSE) run -e MIX_ENV=test --entrypoint make app test

.PHONY: compose_ps
compose_ps:  ## status of containers
	@$(COMPOSE) ps

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
