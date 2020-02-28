#!/usr/bin/env bash
set -e
set -Euo pipefail

trap 'rm -rf ${TEMP_DIR}' EXIT

TEMP_DIR=$(mktemp -d)
CHECKSUM_DIR=$(readlink -f ./checksums)
METADATA_DIR=$(readlink -f ./metadata)
# shellcheck disable=SC2016
REGEX='s/^zulu([0-9+_.]{2,})-(?:(ca-fx-dbg|ca-fx|ca-dbg|ca|ea|dbg)-)?(jdk|jre)(.*)-(linux|macosx|win)_(musl_x64|x64|i686)\.(.*)$/VERSION="$1" RELEASE_TYPE="$2" VARIANT="$3" JAVA_VERSION="$4" OS="$5" ARCH="$6" ARCHIVE="$7"/g'

function ensure_directory {
	if [ ! -d "${1}" ]
	then
		mkdir -p "${1}"
	fi
}

ensure_directory "${CHECKSUM_DIR}"
ensure_directory "${METADATA_DIR}"

INDEX_FILE="${TEMP_DIR}/index.html"
curl --silent --show-error --fail --output "${INDEX_FILE}" 'https://static.azul.com/zulu/bin/'

ZULU_FILES=$(grep -o -E '<a href="(zulu.+-(linux|macosx|win)_(musl_x64|x64|i686)\.(tar\.gz|zip|msi|dmg))">' "${INDEX_FILE}" | perl -pe 's/<a href="(.+)">/$1/g' | sort -V)
for ZULU_FILE in ${ZULU_FILES}
do
	METADATA_FILE="${METADATA_DIR}/${ZULU_FILE}.json"
	ZULU_ARCHIVE="${TEMP_DIR}/${ZULU_FILE}"
	ZULU_URL="https://static.azul.com/zulu/bin/${ZULU_FILE}"
	if [[ -f "${METADATA_FILE}" ]]
	then
		echo "Skipping ${ZULU_FILE}"
	else
		curl --silent --show-error --fail -w "%{filename_effective}\n" --output "${ZULU_ARCHIVE}" "${ZULU_URL}"
		MD5=$(md5sum "${ZULU_ARCHIVE}" | cut -f 1 -d ' ')
		echo "${MD5}  ${ZULU_FILE}" > "${CHECKSUM_DIR}/${ZULU_FILE}.md5"
		SHA1=$(sha1sum "${ZULU_ARCHIVE}"| cut -f 1 -d ' ') 
		echo "${SHA1}  ${ZULU_FILE}" > "${CHECKSUM_DIR}/${ZULU_FILE}.sha1"
		SHA256=$(sha256sum "${ZULU_ARCHIVE}" | cut -f 1 -d ' ')
		echo "${SHA256}  ${ZULU_FILE}" > "${CHECKSUM_DIR}/${ZULU_FILE}.sha256"
		SHA512=$(sha512sum "${ZULU_ARCHIVE}" | cut -f 1 -d ' ')
		echo "${SHA512}  ${ZULU_FILE}" > "${CHECKSUM_DIR}/${ZULU_FILE}.sha512"

		# Parse meta-data from file name
		eval "$(echo "${ZULU_FILE}" | perl -pe "${REGEX}")"

		METADATA_JSON="{
  \"filename\": \"${ZULU_FILE}\",
  \"url\": \"${ZULU_URL}\",
  \"md5\": \"${MD5}\",
  \"md5_file\": \"${ZULU_FILE}.md5\",
  \"sha1\": \"${SHA1}\",
  \"sha1_file\": \"${ZULU_FILE}.sha1\",
  \"sha256\": \"${SHA256}\",
  \"sha256_file\": \"${ZULU_FILE}.sha256\",
  \"sha512\": \"${SHA512}\",
  \"sha512_file\": \"${ZULU_FILE}.sha512\",
  \"version\": \"${VERSION}\",
  \"release_type\": \"${RELEASE_TYPE}\",
  \"variant\": \"${VARIANT}\",
  \"java_version\": \"${JAVA_VERSION}\",
  \"os\": \"${OS}\",
  \"arch\": \"${ARCH}\",
  \"archive_type\": \"${ARCHIVE}\"
}"
		echo "${METADATA_JSON}" > "${METADATA_FILE}"
		rm -f "${ZULU_ARCHIVE}"
	fi
done
jq -M -s -S . "${METADATA_DIR}"/zulu*.json > "${METADATA_DIR}/releases.json"
