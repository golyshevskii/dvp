DT_NOW := $(shell date)

# FORMATTING
format:
	@$(info $(DT_NOW) | INFO | Makefile → Formatting...)
	poetry run black dvp_py
	poetry run isort dvp_py
	poetry run flake8 dvp_py

format-check:
	@$(info $(DT_NOW) | INFO | Makefile → Format checking...)
	poetry run black --check dvp_py
	poetry run isort --check dvp_py
	poetry run flake8 dvp_py

# DBT
dbt-debug:
	@$(info $(DT_NOW) | INFO | Makefile → Running dbt debug...)
	@cd dvp_dbt && dbt debug
