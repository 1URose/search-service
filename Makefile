# Makefile для сервиса search

# ────────────────────────────────────────
# Переменные
# ────────────────────────────────────────
GO           := go
SWAG         := swag
DOCKER_PATH  := docker-compose -f docker/docker-compose.yml
MAIN_PATH    := ./cmd/user_service/main.go
BINARY       := bin/search

.DEFAULT_GOAL := help

# ----------------------------------------
# Помощь
# ----------------------------------------
.PHONY: help
help: ## Показать справочное сообщение
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	  | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# ----------------------------------------
# Установка зависимостей и инструментов
# ----------------------------------------
.PHONY: deps
deps: ## Установить Go-модули и инструменты и загрузить .env
	@echo "---- deps: Начало ----"
	@echo "→ Загрузка переменных из .env..."
	@{ \
	  if [ -f .env ]; then \
	    echo "   • Найден .env, экспортирую…"; \
	    set -a; \
	    export $$(sed 's/\r$$//' .env | grep -v '^\s*#' | xargs); \
	    set +a; \
	    echo "   • Проверка (для примера):"; \
	    echo "       KIBANA_PASSWORD         =$$KIBANA_PASSWORD"; \
	    echo "       STACK_VERSION           =$$STACK_VERSION"; \
	    echo "       KAFKA_BOOTSTRAP_SERVERS =$$KAFKA_BOOTSTRAP_SERVERS"; \
	  else \
	    echo "   • Файл .env не найден, пропускаю"; \
	  fi \
	}
	@echo "→ Проверка Go-модулей…"
	@$(GO) mod tidy
	@$(GO) mod download
	@echo "→ Проверка инструментов…"
	@command -v $(SWAG) >/dev/null 2>&1 || { echo "  • Устанавливаю swag…"; $(GO) install github.com/swaggo/swag/cmd/swag@latest; }
	@echo "---- deps: Завершено ----"


# ----------------------------------------
# Сборка и запуск
# ----------------------------------------
.PHONY: build
build: ## Собрать бинарник сервиса
	@echo "---- build: Начало ----"
	@mkdir -p bin
	@$(GO) build -o $(BINARY) ./cmd/search_service
	@echo "---- build: Завершено ----"

.PHONY: run
run: build ## Собрать и запустить сервис (требует .env)
	@echo "---- run: Начало ----"
	@echo "Запуск сервиса..."
	@$(BINARY)
	@echo "---- run: Завершено ----"

.PHONY: start
start: build ## Собрать и запустить сервис в фоне
	@echo "---- start: Начало ----"
	@echo "Запуск сервиса в фоне..."
	@$(BINARY) & echo $$! > .search.pid
	@echo "PID сохранён в .search.pid: $$(cat .search.pid)"
	@echo "---- start: Завершено ----"

.PHONY: stop
stop: ## Остановить сервис, используя PID
	@echo "---- stop: Начало ----"
	@if [ -f .search.pid ]; then \
		kill `cat .search.pid` && echo "Сервис остановлен"; \
		rm .search.pid; \
	else \
		echo "PID-файл не найден, сервис может быть не запущен"; \
	fi
	@echo "---- stop: Завершено ----"

# ----------------------------------------
# Swagger-документация
# ----------------------------------------
.PHONY: swagger
swagger: ## Сгенерировать Swagger-документацию (требуется swag)
	@echo "---- swagger: Начало ----"
	@$(SWAG) init -g ./internal/app/search.go
	@echo "---- swagger: Завершено ----"

# ----------------------------------------
# Docker Compose
# ----------------------------------------
.PHONY: docker-up
docker-up: ## Запустить сервисы Docker Compose с указанием .env
	@echo "---- docker-up: Начало ----"
	@docker-compose \
	  --env-file .env \
	  -f docker/docker-compose.yml up -d
	@echo "---- docker-up: Завершено ----"


.PHONY: docker-down
docker-down: ## Остановить сервисы Docker Compose
	@echo "---- docker-down: Начало ----"
	@docker-compose \
    	  --env-file .env \
    	  -f docker/docker-compose.yml down
	@echo "---- docker-down: Завершено ----"

.PHONY: docker-down-v
docker-down-v: ## Остановить и удалить сервисы Docker Compose вместе с volume
	@echo "---- docker-down-v: Начало ----"
	@docker-compose \
    	  --env-file .env \
    	  -f docker/docker-compose.yml down -v
	@echo "---- docker-down-v: Завершено ----"

# ----------------------------------------
# Очистка
# ----------------------------------------
.PHONY: clean
clean: ## Удалить собранные бинарники
	@echo "---- clean: Начало ----"
	@rm -rf bin
	@echo "---- clean: Завершено ----"

# ----------------------------------------
# Полный цикл запуска
# ----------------------------------------
.PHONY: up-all
up-all: deps swagger docker-up run ## Установить зависимости, сгенерировать Swagger, поднять Docker и запустить сервис
	@echo "---- up-all: Завершено ----"

# ----------------------------------------
# Полная остановка всех сервисов
# ----------------------------------------
.PHONY: down-all
down-all: stop docker-down  ## Остановить сервис и Docker Compose
	@echo "---- down-all: Завершено ----"
