# Zulu Community™ Release Metadata

The update script in this repository collects a list of the currently available Zulu Community™ OpenJDK builds and their metadata to store it as JSON files in the `metadata/` directory in this repository.

Additionally the script stores MD5, SHA-1, SHA-256, and SHA-512 checksums of the artifacts which are compatible with `md5sum`, `sha1sum`, `sha256sum`, and `sha512sum` in the `checksums/` directory in this repository.

## Metadata structure

```json
{
  "filename": "${ZULU_FILE}", // filename of the artifact
  "url": "${ZULU_URL}", // full source URL of the artifact
  "md5": "${MD5}", // MD5 checksum of the artifact
  "md5_file": "${ZULU_FILE}.md5", // filename of the MD5 checksum file
  "sha1": "${SHA1}", // SHA-1 checksum of the artifact
  "sha1_file": "${ZULU_FILE}.sha1", // filename of the SHA-1 checksum file
  "sha256": "${SHA256}", // SHA-256 checksum of the artifact
  "sha256_file": "${ZULU_FILE}.sha256", filename of the SHA-256 checksum file
  "sha512": "${SHA512}", // SHA-512 checksum of the artifact
  "sha512_file": "${ZULU_FILE}.sha512", filename of the SHA-512 checksum file
  "version": "${VERSION}", // Zulu Community™ version
  "release_type": "${RELEASE_TYPE}", // ca, ea, ca-fx
  "variant": "${VARIANT}", // jre, jdk
  "java_version": "${JAVA_VERSION}", // Java version the artifact is based on
  "os": "${OS}", // linux, macosx, win
  "arch": "${ARCH}", // i686, musl_x64, x64
  "archive_type": "" // .tar.gz, .zip, .dmg, .msi
}
```

## Disclaimer

This project is in no way affiliated with [Azul Systems, Inc.](https://www.azul.com/) or [Zulu Community™](https://www.azul.com/products/zulu-community/).
