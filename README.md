# Sourcemod-CI-Dockerfile
A docker sourcemod plugins build environment, based on debian

## Installation
TODO

## Use together with GitLab runner
If you want to use this docker image for your sourcemod plugins, using GitLab, here some short notes how to.

### .gitlab-ci.yml
GitLab uses a .yml configuration file for the runner configuration. If you completly new to this, have a look at the [docs over at GitLab](https://docs.gitlab.com/ce/ci/examples/README.html).

This docker images adds a little wrapper script for the script compile precedure, which is callable by simply running the spcom command (registered as symlink to the real script).
The script is basically looking for *.sp files in the build directory and compiles those.

So all you have to do in your .gitlab-ci.yml is *invoking the command "spcomp"* after the docker machine is started. This will then start the compilation of your plugins.
