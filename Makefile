DT_NOW := $(shell date)

# FORMATTING
format:
	@$(info $(DT_NOW) | INFO | Makefile → Formatting...)
	poetry run black .
	poetry run isort .
	poetry run flake8 .

format-check:
	@$(info $(DT_NOW) | INFO | Makefile → Format checking...)
	poetry run black --check .
	poetry run isort --check .
