#!/usr/bin/env bash
# Read only; do not upload output to public GitHub.
set -u
cat /etc/os-release
uname -r
uname -m
stat -fc %T /sys/fs/cgroup
test -r /sys/kernel/btf/vmlinux && echo "BTF present" || echo "BTF missing"
findmnt -t bpf || true
systemctl is-active docker kubelet cri-docker.service || true
ls -al /etc/cni/net.d/ 2>/dev/null || true
if command -v bpftool >/dev/null && [ "$(id -u)" -eq 0 ]; then bpftool feature probe kernel; fi
