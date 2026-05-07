DOCKER_COMPOSE ?= docker compose
SERVICE ?= flutter
APP_ENV ?= dev
APP_NAME ?= Template App
BRAND_NAME ?= Template Brand
APPLICATION_ID ?= com.example.template.app
API_BASE_URL ?= https://api.example.com
FLUTTER_DEFINES = --dart-define=APP_ENV='$(APP_ENV)' --dart-define=APP_NAME='$(APP_NAME)' --dart-define=BRAND_NAME='$(BRAND_NAME)' --dart-define=APPLICATION_ID='$(APPLICATION_ID)' --dart-define=API_BASE_URL='$(API_BASE_URL)'

define run_in_container
	$(DOCKER_COMPOSE) run --rm $(SERVICE) bash -lc "$(1)"
endef

.PHONY: setup gen lint test ci build-web build-android build-aab build-linux shell

setup:
	$(call run_in_container,flutter pub get)

gen:
	$(call run_in_container,dart run build_runner build)

lint:
	$(call run_in_container,flutter analyze)

test:
	$(call run_in_container,flutter test)

ci:
	$(call run_in_container,git config --global --add safe.directory /workspace && dart format --output=none --set-exit-if-changed . && flutter analyze && flutter test && dart run build_runner build && git diff --exit-code && flutter build web --release $(FLUTTER_DEFINES))

build-web:
	$(call run_in_container,flutter build web --release $(FLUTTER_DEFINES))

build-android:
	$(call run_in_container,flutter build apk --release $(FLUTTER_DEFINES))

build-aab:
	$(call run_in_container,flutter build appbundle --release $(FLUTTER_DEFINES))

build-linux:
	$(call run_in_container,flutter build linux --release $(FLUTTER_DEFINES))

shell:
	$(DOCKER_COMPOSE) run --rm $(SERVICE) bash
