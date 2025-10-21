# IRsec-toolkit

## busybox-static
The busybox binary can't be affected by userland rootkits (those that utilize LD_PRELOAD or /etc/ld.so.preload tactics). None of its libraries or dependencies can be tampered with as they're all already included due to it being **statically** compiled

