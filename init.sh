#!/bin/bash

if [ ! -f /opt/factorio/saves/${FACTORIO_SAVE_NAME}.zip ]; then
  /opt/factorio/bin/x64/factorio --create ${FACTORIO_SAVE_NAME}.zip
fi
exec /opt/factorio/bin/x64/factorio --start-server ${FACTORIO_SAVE_NAME}.zip --autosave-interval ${FACTORIO_AUTOSAVE_INTERVAL} --autosave-slots ${FACTORIO_AUTOSAVE_SLOTS}
