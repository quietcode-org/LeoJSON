#!/bin/sh

set -u

STATUS=0

echo "LeoJSON repository hygiene check"

echo "Checking executable Markdown files..."
EXEC_MD=`find . -name '*.md' -perm -111 -print`

if [ "x$EXEC_MD" != "x" ]; then
    echo "FAIL: Markdown files must not be executable:"
    echo "$EXEC_MD"
    STATUS=1
else
    echo "OK: no executable Markdown files"
fi

echo "Checking required executable tools..."

if [ ! -x tools/leojson_utf8_boundary_inventory.sh ]; then
    echo "FAIL: tools/leojson_utf8_boundary_inventory.sh is not executable"
    STATUS=1
else
    echo "OK: UTF8 boundary inventory tool is executable"
fi

if [ "$STATUS" -eq 0 ]; then
    echo "OK: repository hygiene check passed"
else
    echo "FAIL: repository hygiene check failed"
fi

exit "$STATUS"

