# IRsec-toolkit

## busybox-static
The busybox binary can't be affected by userland rootkits (e.g those that tamper with LD_PRELOAD or patch built-in commands). None of its libraries or dependencies can be tampered with as they're all already included due to it being **statically** compiled

Not effective against kernel rootkits since busybox, like most executables, relies on the kernel to fetch information and perform other actions

