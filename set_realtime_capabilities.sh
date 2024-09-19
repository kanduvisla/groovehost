#!/usr/bin/bash

if [ -x /sbin/setcap ]; then
    # Give all binaries in the package realtime capabilities:
    JACKBINS=( $(cd /usr/bin ; find ./jack* -type f -printf '%P\n') )
    for EXE in \${JACKBINS[@]}; do
      echo $EXE
      # /sbin/setcap cap_ipc_lock,cap_sys_nice=ep usr/bin/\$EXE
    done
fi
