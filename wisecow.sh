#!/usr/bin/env bash

SRVPORT=4499
RSPFILE=response

cleanup() {
    rm -f "$RSPFILE"
}

trap cleanup EXIT

mkfifo "$RSPFILE"

get_api() {
    read line
    echo "$line"
}

handleRequest() {
    local mod
    mod=$(fortune)

    cat <<EOF > "$RSPFILE"
HTTP/1.1 200

<pre>$(cowsay "$mod")</pre>
EOF
}

prerequisites() {
    command -v cowsay >/dev/null 2>&1 ||
    {
        echo "Install cowsay."
        exit 1
    }

    command -v fortune >/dev/null 2>&1 ||
    {
        echo "Install fortune."
        exit 1
    }
}

main() {
    prerequisites

    echo "Wisdom served on port=$SRVPORT..."

    while true; do
        cat "$RSPFILE" | nc -lN "$SRVPORT" | handleRequest
        sleep 0.01
    done
}

main

