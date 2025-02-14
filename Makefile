_bootstrap_models:
	docker compose --profile download --build

comfyui-fresh-start:
	$(MAKE) _bootstrap_models
	docker compose --profile comfyui up --build

auto-fresh-start:
	$(MAKE) _bootstrap_models
	docker compose --profile auto up --build

