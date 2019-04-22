.PHONY: init  # Initialize application
init:
	python -m venv venv; \
	source venv/bin/activate

.PHONY: dependencies  # Install requirements
dependencies:
	pip install -r requirements.txt

.PHONY: run-by-cli
run-by-cli:
	python cli.py

.PHONY: run-by-flask
run-by-flask:
	export FLASK_APP=main/app; \
	flask run
