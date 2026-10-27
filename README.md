# docker fpm php-8 phalcon-5

Docker image PHP-FPM 8 multi-version (PHP 8.5 & PHP 8.3) dengan Phalcon 5.23 dan ekstensi pendukung umum (MySQL, PostgreSQL, Redis, SQL Server, GD, Zip, IonCube, dll.).

## Tag Image

| Versi PHP | Versi Phalcon | Tag Docker Hub | Tag GHCR | Keterangan |
| :--- | :--- | :--- | :--- | :--- |
| **8.5** | `5.23.0` | `nimdasx/fpm-php8-phalcon5:8.5`, `latest` | `ghcr.io/nimdasx/fpm-php8-phalcon5:8.5`, `latest` | Default / Latest |
| **8.3** | `5.23.0` | `nimdasx/fpm-php8-phalcon5:8.3` | `ghcr.io/nimdasx/fpm-php8-phalcon5:8.3` | Stable PHP 8.3 |

---

## Catatan
- Phalcon 5.23 kompatibel dengan PHP 8.3 dan PHP 8.5.
- Multibuilder lokal dan remote cek [panduan docker buildx](https://github.com/nimdasx/gits/blob/main/docker.md#lokal-builder-for-amd64-remote-builder-for-arm64).

---

## Cara Build

### 1. Menggunakan Script Helper (`build.sh`)

Tersedia script `build.sh` untuk mempermudah proses build:

```bash
# Tampilkan bantuan
./build.sh --help

# Build lokal (load ke docker images lokal)
./build.sh 8.5        # Hanya build PHP 8.5
./build.sh 8.3        # Hanya build PHP 8.3
./build.sh all        # Build kedua versi

# Build multi-platform (linux/amd64,linux/arm64) dan push ke registry
./build.sh 8.5 --push
./build.sh 8.3 --push
./build.sh all --push
```

### 2. Manual dengan `docker buildx`

#### PHP 8.5 (Default / Latest)
```bash
# Push ke GHCR dan Docker Hub
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg PHP_VERSION=8.5 \
  --build-arg PHALCON_VERSION=5.23.0 \
  -t ghcr.io/nimdasx/fpm-php8-phalcon5:8.5 \
  -t ghcr.io/nimdasx/fpm-php8-phalcon5:latest \
  -t nimdasx/fpm-php8-phalcon5:8.5 \
  -t nimdasx/fpm-php8-phalcon5:latest \
  --push .
```

#### PHP 8.3
```bash
# Push ke GHCR dan Docker Hub
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg PHP_VERSION=8.3 \
  --build-arg PHALCON_VERSION=5.23.0 \
  -t ghcr.io/nimdasx/fpm-php8-phalcon5:8.3 \
  -t nimdasx/fpm-php8-phalcon5:8.3 \
  --push .
```

---

## CI/CD (GitHub Actions)

Repositori ini dilengkapi dengan workflow GitHub Actions (`.github/workflows/docker-build.yml`) yang otomatis melakukan matrix build (PHP 8.5 dan 8.3) untuk arsitektur `linux/amd64` dan `linux/arm64`:
- Terpicu saat push ke branch `main` atau membuat release tag `v*`.
- Mendukung trigger manual via **Actions -> Run workflow**.
- Memerlukan secret `DOCKERHUB_USERNAME` dan `DOCKERHUB_TOKEN` jika ingin otomatis push ke Docker Hub (push ke GHCR otomatis aktif via `GITHUB_TOKEN`).