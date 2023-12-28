DT_NOW := $(shell date)

# FORMATTING
format:
	@$(info $(DT_NOW) | INFO | Makefile → Formatting...)
	poetry run black scripts
	poetry run isort scripts
	poetry run flake8 scripts

format-check:
	@$(info $(DT_NOW) | INFO | Makefile → Format checking...)
	poetry run black --check scripts
	poetry run isort --check scripts
	poetry run flake8 scripts

# DBT
dbt-debug:
	@$(info $(DT_NOW) | INFO | Makefile → Running dbt debug...)
	@cd dvp_dbt && dbt debug
