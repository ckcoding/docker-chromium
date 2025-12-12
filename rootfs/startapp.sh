#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

export HOME=/config

rm -rf /config/chromium/Singleton*

SANDBOX_ARG=
if ! check_pid_namespace >/dev/null; then
    SANDBOX_ARG=--no-sandbox
fi

exec /usr/bin/chromium-browser \
    $SANDBOX_ARG \
    --disable-dev-shm-usage \
    --ignore-gpu-blocklist \
    --simulate-outdated-no-au='Tue, 31 Dec 2099 23:59:59 GMT' \
    --start-maximized \
    --user-data-dir=/config/chromium \
    >> /config/log/chromium/output.log 2>> /config/log/chromium/error.log

# vim:ft=sh:ts=4:sw=4:et:sts=4
