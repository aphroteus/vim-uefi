#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MINIVIMRC="${SCRIPT_DIR}/minivimrc"
RUN_ALL="${SCRIPT_DIR}/run_all.vim"
LOG_FILE="${SCRIPT_DIR}/test.log"

rm -f "${LOG_FILE}"

echo "Running vim-uefi automated test suite..."
vim --clean -Nu "${MINIVIMRC}" -es -S "${RUN_ALL}"
EXIT_CODE=$?

if [[ -f "${LOG_FILE}" ]]; then
    cat "${LOG_FILE}"
fi

if [[ ${EXIT_CODE} -ne 0 ]]; then
    echo "Test suite failed with exit code ${EXIT_CODE}" >&2
fi

exit ${EXIT_CODE}
