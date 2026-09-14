IMAGE := python:3.13-slim

help: ## Affiche l'aide
	@echo "Commandes disponibles :"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

env: ## Génère le fichier .env du projet
	@echo "UID=$$(id -u)" > .env
	@echo "GID=$$(id -g)" >> .env

up: ## Démarre le container
	docker compose up -d

down: ## Stoppe le container
	docker compose down

rebuild: ## Rebuild et relance le container
	docker compose up --build -d

serve: ## Lance le serveur FastAPI sur http://localhost:8000
	docker compose exec python uvicorn main:app --host 0.0.0.0 --port 8000 --reload

sh: ## Ouvre un invité de commande dans le container
	docker compose exec python sh

lock: ## Régnère les dépendances du projet
	docker run --rm \
		--user "$(shell id -u):$(shell id -g)" \
		-e HOME=/tmp \
		-v "$(shell pwd):/app" -w /app ${IMAGE} \
		bash -c "pip install --user --no-warn-script-location pip-tools -q && \
		 ~/.local/bin/pip-compile requirements.in --output-file=requirements.txt"

clean: ## Arrête le container et supprimer l'image locale
	docker compose down --rmi local