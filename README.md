# Zulu Community™ Release Metadata

![Update release metadata](https://github.com/joschi/zulu-metadata/workflows/Update%20release%20metadata/badge.svg)

The update script in this repository collects a list of the currently available Zulu Community™ OpenJDK builds and their metadata to store it as JSON files in the `metadata/` directory in this repository.

Additionally the script stores MD5, SHA-1, SHA-256, and SHA-512 checksums of the artifacts which are compatible with `md5sum`, `sha1sum`, `sha256sum`, and `sha512sum` in the `checksums/` directory in this repository.

## Metadata structure

| Field name     | Description                           |
| -------------- | ------------------------------------- |
| `filename`     | Filename of the artifact              |
| `url`          | Full source URL of the artifact       |
| `md5`          | MD5 checksum of the artifact          |
| `md5_file`     | Filename of the MD5 checksum file     |
| `sha1`         | SHA-1 checksum of the artifact        |
| `sha1_file`    | Filename of the SHA-1 checksum file   |
| `sha256`       | SHA-256 checksum of the artifact      |
| `sha256_file`  | Filename of the SHA-256 checksum file |
| `sha512`       | SHA-512 checksum of the artifact      |
| `sha512_file`  | Filename of the SHA-512 checksum file |
| `version`      | Zulu Community™ version               |
| `release_type` | `ca` (stable), `ca-fx` (stable with JavaFX), `ea` (early access) |
| `variant`      | `jre`, `jdk`                          |
| `java_version` | Java version the artifact is based on |
| `os`           | `linux`, `macosx`, `win`              |
| `arch`         | `i686`, `musl_x64` (built against [musl libc](https://musl.libc.org/)), `x64` |
| `archive_type` | `tar.gz`, `zip`, `dmg`, `msi`         |


Example:

```json
{
  "filename": "${ZULU_FILE}",
  "url": "${ZULU_URL}",
  "md5": "${MD5}",
  "md5_file": "${ZULU_FILE}.md5",
  "sha1": "${SHA1}",
  "sha1_file": "${ZULU_FILE}.sha1",
  "sha256": "${SHA256}",
  "sha256_file": "${ZULU_FILE}.sha256",
  "sha512": "${SHA512}",
  "sha512_file": "${ZULU_FILE}.sha512",
  "version": "${VERSION}",
  "release_type": "${RELEASE_TYPE}",
  "variant": "${VARIANT}",
  "java_version": "${JAVA_VERSION}",
  "os": "${OS}",
  "arch": "${ARCH}",
  "archive_type": "${ARCHIVE}"
}
```

## Disclaimer

This project is in no way affiliated with [Azul Systems, Inc.](https://www.azul.com/) or [Zulu Community™](https://www.azul.com/products/zulu-community/).
