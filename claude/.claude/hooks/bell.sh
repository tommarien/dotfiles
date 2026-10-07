#!/usr/bin/env bash
# Hooks have no controlling tty: ring the bell on the nearest ancestor's tty.
p=$$
while [ "$p" -gt 1 ]; do
    t=$(ps -o tty= -p "$p" | tr -d ' ')
    if [ -n "$t" ] && [ "$t" != "??" ]; then
        printf '\a' > "/dev/$t"
        exit 0
    fi
    p=$(ps -o ppid= -p "$p" | tr -d ' ')
done
