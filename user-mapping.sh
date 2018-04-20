#!/bin/bash

if [ -z "${FIBERFY_UNIX_USER}" ]; then
  echo "We need USER to be set!"; exit 100
fi

# if both not set we do not need to do anything
if [ -z "${HOST_USER_ID}" -a -z "${HOST_USER_GID}" ]; then
    echo "Nothing to do here." ; exit 0
fi

# reset user_?id to either new id or if empty old (still one of above
# might not be set)
USER_ID=${HOST_USER_ID:=$FIBERFY_USER_ID}
USER_GID=${HOST_USER_GID:=$FIBERFY_USER_GID}

LINE=$(grep -F "${FIBERFY_UNIX_USER}" /etc/passwd)
# replace all ':' with a space and create array
array=( ${LINE//:/ } )

# home is 5th element
USER_HOME=${array[4]}

sed -i -e "s/^${FIBERFY_UNIX_USER}:\([^:]*\):[0-9]*:[0-9]*/${FIBERFY_UNIX_USER}:\1:${FIBERFY_USER_ID}:${FIBERFY_USER_GID}/"  /etc/passwd
sed -i -e "s/^${FIBERFY_UNIX_USER}:\([^:]*\):[0-9]*/${FIBERFY_UNIX_USER}:\1:${FIBERFY_USER_GID}/"  /etc/group

chown -R ${FIBERFY_USER_ID}:${FIBERFY_USER_GID} ${USER_HOME}

exec su - "${FIBERFY_UNIX_USER}"
