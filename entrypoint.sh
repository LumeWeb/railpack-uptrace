#!/bin/bash
set -euo pipefail

CONFIG="${UPTRACE_CONFIG:-/data/uptrace.yml}"

if [ $# -eq 0 ]; then
    echo "Waiting for PostgreSQL..."
    /out/uptrace --config="$CONFIG" pg wait

    echo "Waiting for ClickHouse..."
    /out/uptrace --config="$CONFIG" ch wait

    echo "Starting Uptrace..."
    exec /out/uptrace --config="$CONFIG" serve
else
    exec /out/uptrace --config="$CONFIG" "$@"
fi
