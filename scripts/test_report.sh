#!/bin/bash

echo "# Running tests"
npm run test:junit

if [[ $? -ne 0 ]]; then
  echo "# Non-zero exit code - some tests may have failed."
fi

echo "# Sending results to jenkins"
npm run jenkins

if [[ $? -eq 0 ]]; then
  echo "# Results sent to Jenkins successfully."
fi

exit $?