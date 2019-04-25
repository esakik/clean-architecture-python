.PHONY: init  # Initialize application
init:
	python -m venv venv; \
	source venv/bin/activate

.PHONY: dependencies  # Install requirements
dependencies:
	pip install -r requirements.txt

.PHONY: run-by-cli
run-cli:
	python cli.py

.PHONY: run-by-flask
run-flask:
	export FLASK_APP=main/app; \
	flask run
