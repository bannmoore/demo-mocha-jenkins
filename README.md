# Continuous Integration: Mocha + Jenkins, Trigger Remote Build

This demo uses npm scripts to remotely trigger a manual Jenkins job that accepts an XML file parameter.

## Set Up

### Jenkins Local Set Up

Note: This section is optional if you have a Jenkins server available to test with.

Most of Jenkins' data resides in `/var/jenkins_home` on the docker container. The `jenkins` service in this repo sets up a volume between that folder and `testrail/jenkins/jenkins_home` in this repo, so once you've performed the set up once you shouldn't need to do it again.

If you don't want to lose your configuration, _don't_ delete `docker/jenkins/jenkins_home`.

#### Bring Up The Container and Provide The Admin Password

```sh
docker-compose up jenkins
```

Look for this section in the logs to retrieve the admin password:

```
jenkins_1   | Please use the following password to proceed to installation:
jenkins_1   |
jenkins_1   | *SOME_PASSWORD_STRING*
jenkins_1   |
jenkins_1   | This may also be found at: /var/jenkins_home/secrets/initialAdminPassword
```

Navigate to `localhost:8080` and provide the password on the "Unlock Jenkins" screen. Provide an admin user (dummy data will work, but remember the username and password) and let Jenkins install the default plugins.

#### Create the Job

For the purposes of this demo, we'll create a simple job that just accepts a file input and `cat`s it to the console. This is the minimum setup needed.

- Under General, check "This project is parameterized."
  - Select a file parameter, and for "File Location" provide `input.xml`.
- Under Build, click "Add build step", then select "Execute shell".
  - In the Command input, provide `cat input.xml`.
- Scroll to the bottom and click Save.

That's it! To test your manual build, you can select "Build with Parameters" from the job screen, and upload an XML file manually. It should print the contents to the build's console.

## Trigger a Build Programatically

From the code repository, this command should run tests and send the XML results to Jenkins:

```js
npm run test:report
```

There's a few environment variables you may need to update in `scripts/send_to_jenkins.sh`. Make sure these values correspond with your Jenkins instance.

```sh
JENKINS_URL=http://localhost:8080
JENKINS_JOB_NAME=Receive%20Test%20Results
JENKINS_USERNAME=admin
JENKINS_PASSWORD=admin
```