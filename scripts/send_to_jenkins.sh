#!/bin/bash

JENKINS_URL=http://localhost:8080
JENKINS_JOB_NAME=Receive%20Test%20Results
JENKINS_USERNAME=admin
JENKINS_PASSWORD=admin

JENKINS_CRUMB_HEADER=$(wget -q --auth-no-challenge \
  --user $JENKINS_USERNAME \
  --password $JENKINS_PASSWORD \
  --output-document - \
  $JENKINS_URL'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')

curl -X POST "$JENKINS_URL/job/$JENKINS_JOB_NAME/build" \
  --header $JENKINS_CRUMB_HEADER \
  --user $JENKINS_USERNAME:$JENKINS_PASSWORD \
  --form file0=@$1 \
  --form json='{"parameter": [{"name":"input.xml", "file":"file0"}]}'