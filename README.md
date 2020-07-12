# Deprecated: See https://github.com/joschi/java-metadata for a replacement

----

# Zulu Community™ Release Metadata

![Update release metadata](https://github.com/joschi/zulu-metadata/workflows/Update%20release%20metadata/badge.svg)

The update script in this repository collects a list of the currently available Zulu Community™ OpenJDK builds and their metadata to store it as JSON files in the `metadata/` directory in this repository.

Additionally the script stores MD5, SHA-1, SHA-256, and SHA-512 checksums of the artifacts which are compatible with `md5sum`, `sha1sum`, `sha256sum`, and `sha512sum` in the `checksums/` directory in this repository.

## Usage

You can fetch the latest metadata for all Zulu Community™ releases at the following URL:

```
https://github.com/joschi/zulu-metadata/raw/master/metadata/releases.json
```

Example with cURL (requesting a compressed version which significantly reduces the transfer size):

```
curl --compressed -L https://github.com/joschi/zulu-metadata/raw/master/metadata/releases.json
```

If you want to fetch the checksum manifests for a Zulu Community™ release, you can download it with the following URL template:

```
https://github.com/joschi/zulu-metadata/raw/master/checksums/{artifact_filename}.{hash_function}
```

* `artifact_filename`: The original filename of the artifact, for example `zulu11.37.17-ca-jre11.0.6-linux_x64.tar.gz`
* `hash_algorithm`: The hash function you want to use; valid values are `md5`, `sha1`, `sha256`, and `sha512`

Example with cURL and SHA-256 checksum:

```
# Download Zulu Community™ JRE 11.37.17 for Linux (x64)
curl -O https://static.azul.com/zulu/bin/zulu11.37.17-ca-jre11.0.6-linux_x64.tar.gz
# Download SHA-256 checksum manifest for Zulu Community™ JRE 11.37.17 for Linux (x64)
curl -L -O https://github.com/joschi/zulu-metadata/raw/master/checksums/zulu11.37.17-ca-jre11.0.6-linux_x64.tar.gz.sha256
# Verify checksum
sha256sum -c zulu11.37.17-ca-jre11.0.6-linux_x64.tar.gz.sha256
```

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
  "filename": "zulu8.44.0.13-ca-fx-jdk8.0.242-linux_x64.tar.gz",
  "url": "https://static.azul.com/zulu/bin/zulu8.44.0.13-ca-fx-jdk8.0.242-linux_x64.tar.gz",
  "md5": "fda058637e054eae280eb8761824d064",
  "md5_file": "zulu8.44.0.13-ca-fx-jdk8.0.242-linux_x64.tar.gz.md5",
  "sha1": "f07e67b9773cadaf539e67b4e26957b9d85220b7",
  "sha1_file": "zulu8.44.0.13-ca-fx-jdk8.0.242-linux_x64.tar.gz.sha1",
  "sha256": "e35bad183b6309384fd440890b4c7888b30670006a6e10ce3d4fefb40fbefc93",
  "sha256_file": "zulu8.44.0.13-ca-fx-jdk8.0.242-linux_x64.tar.gz.sha256",
  "sha512": "2f650295baf38d99794343b04dd2dd81ebeff92fa9c3a8bf110700118d1879e20016c6ff441f4488e87dd1fc733b87836e90ec9ba26184d8288c400e11bc9057",
  "sha512_file": "zulu8.44.0.13-ca-fx-jdk8.0.242-linux_x64.tar.gz.sha512",
  "version": "8.44.0.13",
  "release_type": "ca-fx",
  "variant": "jdk",
  "java_version": "8.0.242",
  "os": "linux",
  "arch": "x64",
  "archive_type": "tar.gz"
}
```

See also [`metadata/`](./metadata/) directory.

## Disclaimer

This project is in no way affiliated with [Azul Systems, Inc.](https://www.azul.com/) or [Zulu Community™](https://www.azul.com/products/zulu-community/).
