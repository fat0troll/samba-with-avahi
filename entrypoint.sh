#!/usr/bin/env bash

while IFS='=' read -r name value ; do
  if [[ $name == 'USER'* ]]; then
    IFS=';'
    read -ra userParams <<< "${!name}"
    echo "Adding user ${userParams[0]}"
    adduser --no-create-home --uid "${userParams[2]}" --ingroup "${userParams[1]}" \
    --disabled-password "${userParams[0]}"
  fi
done < <(env)

nmbd -D
smbd -FS --no-process-group
