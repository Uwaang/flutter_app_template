#!/usr/bin/env bash

set -euo pipefail

KEYSTORE_B64="${ANDROID_KEYSTORE_BASE64:-}"
KEYSTORE_PASSWORD="${ANDROID_KEYSTORE_PASSWORD:-}"
KEY_ALIAS="${ANDROID_KEY_ALIAS:-}"
KEY_PASSWORD="${ANDROID_KEY_PASSWORD:-}"
REQUIRE_SIGNING="${REQUIRE_ANDROID_SIGNING:-false}"
KEYSTORE_DIR="android/keystore"
KEYSTORE_FILE_NAME="${ANDROID_KEYSTORE_FILE_NAME:-upload-keystore.jks}"
KEYSTORE_PATH="${KEYSTORE_DIR}/${KEYSTORE_FILE_NAME}"
KEY_PROPERTIES_PATH="android/key.properties"

if [[ -n "${KEYSTORE_B64}" ]]; then
  if [[ -z "${KEYSTORE_PASSWORD}" || -z "${KEY_ALIAS}" || -z "${KEY_PASSWORD}" ]]; then
    echo "Android signing material is incomplete. Expected ANDROID_KEYSTORE_PASSWORD, ANDROID_KEY_ALIAS, and ANDROID_KEY_PASSWORD." >&2
    exit 1
  fi

  mkdir -p "${KEYSTORE_DIR}"
  printf '%s' "${KEYSTORE_B64}" | base64 --decode > "${KEYSTORE_PATH}"

  cat > "${KEY_PROPERTIES_PATH}" <<EOF
storeFile=keystore/${KEYSTORE_FILE_NAME}
storePassword=${KEYSTORE_PASSWORD}
keyAlias=${KEY_ALIAS}
keyPassword=${KEY_PASSWORD}
EOF

  echo "Android signing files prepared at ${KEY_PROPERTIES_PATH} and ${KEYSTORE_PATH}."
  exit 0
fi

if [[ "${REQUIRE_SIGNING}" == "true" ]]; then
  echo "Android signing is required, but ANDROID_KEYSTORE_BASE64 is not configured." >&2
  exit 1
fi

echo "Android signing variables are not configured. Falling back to template debug signing."
