#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/TonyML7/itm-easydevops.git"
APP_DIR="$HOME/itm-easydevops"

sudo apt update

# Git
sudo apt -y install git

# .NET SDK 8 (Ubuntu)
if ! command -v dotnet >/dev/null 2>&1; then
  sudo apt -y install dotnet-sdk-8.0
fi

# Repo clonen
if [ ! -d "$APP_DIR" ]; then
  git clone "$REPO_URL" "$APP_DIR"
fi

# Frontend runnen
cd "$APP_DIR/frontend/EasyDevOps"
dotnet run --urls "http://0.0.0.0:5000"
