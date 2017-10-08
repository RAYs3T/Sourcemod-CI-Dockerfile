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

#### Example build file for plugins using this
You simply create you repository including you plugin(s).sp and maybe an includes/ folder for third-party (.inc) includes.

Then you add this file called ```.gitlab-ci.yml``` to the repository. Sime as it it, gitlab will build your plugin and provide a downloadable archive for it.
```yml
image: rays3t/sourcemod-plugins-builder-ci
build:
    stage: build
    script: spcomp
    artifacts:
        name: "${CI_PROJECT_NAME}_${CI_COMMIT_REF_NAME}"
        paths:
        - compiled/*
```

If you are just compiling a single plugin you could change the path from the "artifact" to point directly on the compiled/plugin_name.smx file to download it directly
