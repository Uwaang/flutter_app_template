#!/usr/bin/env bash

set -euo pipefail

APP_ENV_VALUE="${APP_ENV:-}"
APP_NAME_VALUE="${APP_NAME:-}"
BRAND_NAME_VALUE="${BRAND_NAME:-}"
APPLICATION_ID_VALUE="${APPLICATION_ID:-}"
API_BASE_URL_VALUE="${API_BASE_URL:-}"
ALLOW_TEMPLATE_PLACEHOLDERS_VALUE="${ALLOW_TEMPLATE_PLACEHOLDERS:-false}"
REQUIRE_ANDROID_SIGNING_VALUE="${REQUIRE_ANDROID_SIGNING:-false}"

fail() {
  echo "Release preflight failed: $*" >&2
  exit 1
}

require_non_blank() {
  local name="$1"
  local value="$2"
  if [[ -z "${value// }" ]]; then
    fail "${name} must be set and must not be blank."
  fi
}

require_non_blank "APP_ENV" "${APP_ENV_VALUE}"
require_non_blank "APP_NAME" "${APP_NAME_VALUE}"
require_non_blank "BRAND_NAME" "${BRAND_NAME_VALUE}"
require_non_blank "APPLICATION_ID" "${APPLICATION_ID_VALUE}"
require_non_blank "API_BASE_URL" "${API_BASE_URL_VALUE}"

case "${APP_ENV_VALUE}" in
  ci|dev|development|stage|staging|prod|production)
    ;;
  *)
    fail "APP_ENV='${APP_ENV_VALUE}' is unknown. Use ci, dev, development, stage, staging, prod, or production."
    ;;
esac

if [[ ! "${APPLICATION_ID_VALUE}" =~ ^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$ ]]; then
  fail "APPLICATION_ID='${APPLICATION_ID_VALUE}' is invalid. Use a reverse-DNS identifier such as com.example.client."
fi

if [[ ! "${API_BASE_URL_VALUE}" =~ ^https?://[^[:space:]]+$ ]]; then
  fail "API_BASE_URL='${API_BASE_URL_VALUE}' is invalid. Use an absolute http(s) URL."
fi

is_prod=false
if [[ "${APP_ENV_VALUE}" == "prod" || "${APP_ENV_VALUE}" == "production" ]]; then
  is_prod=true
fi

if [[ "${is_prod}" == "true" && "${ALLOW_TEMPLATE_PLACEHOLDERS_VALUE}" != "true" ]]; then
  [[ "${APP_NAME_VALUE}" != "Template App" ]] || fail "APP_NAME still uses the template placeholder in production."
  [[ "${BRAND_NAME_VALUE}" != "Template Brand" ]] || fail "BRAND_NAME still uses the template placeholder in production."
  [[ "${APPLICATION_ID_VALUE}" != "com.example.template.app" ]] || fail "APPLICATION_ID still uses the template placeholder in production."
  [[ "${API_BASE_URL_VALUE}" != "https://api.example.com" ]] || fail "API_BASE_URL still uses the template placeholder in production."
fi

if [[ "${GITHUB_EVENT_NAME:-}" == "push" && "${GITHUB_REF:-}" == refs/tags/* ]]; then
  [[ "${is_prod}" == "true" ]] || fail "Tag releases must use APP_ENV=prod or production."
  [[ "${ALLOW_TEMPLATE_PLACEHOLDERS_VALUE}" != "true" ]] || fail "Tag releases must not allow template placeholders."
  [[ "${REQUIRE_ANDROID_SIGNING_VALUE}" == "true" ]] || fail "Tag releases must set REQUIRE_ANDROID_SIGNING=true."
fi

echo "Release preflight passed for APP_ENV=${APP_ENV_VALUE}, APPLICATION_ID=${APPLICATION_ID_VALUE}."
