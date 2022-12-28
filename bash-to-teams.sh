#!/bin/bash
# Usage: teams-chat-post.sh "<title>" "<message>"

# Webhook 
WEBHOOK_URL=""

# Title
TITLE=$1
if [[ "${TITLE}" == "" ]]; then
    echo "No title specified."
    exit 1
fi
shift

# Text
TEXT=$*
if [[ "${TEXT}" == "" ]]; then
    echo "No text specified."
    exit 1
fi

# Convert formating.
MESSAGE=$(echo ${TEXT} | sed 's/"/\"/g' | sed "s/'/\'/g")
JSON="{\"title\": \"${TITLE}\", \"text\": \"${MESSAGE}\" }"

# Post to Microsoft Teams.
curl -H "Content-Type: application/json" -d "${JSON}" "${WEBHOOK_URL}"
