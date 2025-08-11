#!/usr/bin/env bash
set -euo pipefail
python -m pip install --upgrade pip pip-tools
pip-compile constraints/python-constraints.in -o constraints/python-constraints.txt --generate-hashes
echo "Wrote constraints/python-constraints.txt"
