#!/usr/bin/env bash
set -euo pipefail

# Log user-data output
exec > >(tee /var/log/user-data-artifactory.log | logger -t user-data -s 2>/dev/console) 2>&1

ART_VERSION="7.21.5"
ART_TGZ="jfrog-artifactory-oss-${ART_VERSION}-linux.tar.gz"
ART_URL="https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/${ART_VERSION}/${ART_TGZ}"

BASE_DIR="/opt/artifactory"
APP_DIR="${BASE_DIR}/app"     # final target
RUN_USER="artifactory"

echo "==== Installing prerequisites ===="
apt-get update -y
apt-get install -y curl tar gzip unzip jq

echo "==== Installing OpenJDK 17 ===="
apt-get install -y openjdk-17-jdk
java -version || true

echo "==== Creating artifactory user (if needed) ===="
if ! id "${RUN_USER}" >/dev/null 2>&1; then
  useradd --system --create-home --home-dir /var/opt/jfrog --shell /usr/sbin/nologin "${RUN_USER}"
fi

echo "==== Creating directories ===="
mkdir -p "${BASE_DIR}"
cd "${BASE_DIR}"

echo "==== Downloading Artifactory OSS ${ART_VERSION} ===="
# download only if not already present
if [ ! -f "${BASE_DIR}/${ART_TGZ}" ]; then
  curl -fL "${ART_URL}" -o "${BASE_DIR}/${ART_TGZ}"
fi

echo "==== Extracting ===="
# Clean previous extract folder if exists (safe for fresh builds)
rm -rf "${BASE_DIR}/artifactory-oss-${ART_VERSION}" || true
tar -xzf "${BASE_DIR}/${ART_TGZ}"

echo "==== Normalizing folder layout to /opt/artifactory/app ===="
# The tarball extracts as: artifactory-oss-7.21.5/{app,var}
# We'll move that folder to /opt/artifactory/app so you end up with:
# /opt/artifactory/app/app/bin/artifactory.sh (matches your confirmed structure)
rm -rf "${APP_DIR}" || true
mv "${BASE_DIR}/artifactory-oss-${ART_VERSION}" "${APP_DIR}"

echo "==== Setting ownership ===="
chown -R "${RUN_USER}:${RUN_USER}" "${BASE_DIR}"

echo "==== Creating systemd unit ===="
cat >/etc/systemd/system/artifactory.service <<'EOF'
[Unit]
Description=JFrog Artifactory OSS
After=network.target

[Service]
Type=forking
User=artifactory
Group=artifactory
WorkingDirectory=/opt/artifactory/app
ExecStart=/opt/artifactory/app/app/bin/artifactory.sh start
ExecStop=/opt/artifactory/app/app/bin/artifactory.sh stop
TimeoutStartSec=180
TimeoutStopSec=180
Restart=on-failure
RestartSec=10
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

echo "==== Enabling and starting Artifactory ===="
systemctl daemon-reload
systemctl enable artifactory.service
systemctl restart artifactory.service

echo "==== Status (last 20 lines) ===="
systemctl --no-pager --full status artifactory.service | tail -n 40 || true

echo "==== Done. Access Artifactory on port 8081 (default) ===="