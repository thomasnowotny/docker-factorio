#!/bin/bash

if [ ! -f /opt/factorio/saves/${FACTORIO_SAVE_NAME}.zip ]; then
  /opt/factorio/bin/x64/factorio --create ${FACTORIO_SAVE_NAME}.zip
else
  # LATEST_MODIFIED=$(ls /opt/factorio/saves -lt | grep -E "_autosave|${FACTORIO_SAVE_NAME}" | head -1 | awk '{print $(NF);}')
fi

FACTORIO_SERVER_FLAGS=""

if [[ ${FACTORIO_ALLOW_COMMANDS} = "FALSE" ]]; then
  FACTORIO_SERVER_FLAGS="$FACTORIO_SERVER_FLAGS --disallow-commands"
fi

if [[ ${FACTORIO_AUTO_PAUSE} = "FALSE" ]]; then
  FACTORIO_SERVER_FLAGS="$FACTORIO_SERVER_FLAGS --no-auto-pause"
fi

if [[ ${FACTORIO_PEER_TO_PEER} = "TRUE" ]]; then
  FACTORIO_SERVER_FLAGS="$FACTORIO_SERVER_FLAGS --peer-to-peer"
fi

exec /opt/factorio/bin/x64/factorio --start-server ${FACTORIO_SAVE_NAME}.zip --autosave-interval ${FACTORIO_AUTOSAVE_INTERVAL} --autosave-slots ${FACTORIO_AUTOSAVE_SLOTS} --latency-ms ${FACTORIO_LATENCY_MS} $FACTORIO_SERVER_FLAGS

