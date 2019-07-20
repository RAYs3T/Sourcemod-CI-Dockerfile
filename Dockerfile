##########################################
##       Sourcemod CI Dockerfile        ##
##                                      ##
## Written by Kevin 'RAYs3T' Urbainczyk ##
## Creates a build environment for SM   ##
##########################################
FROM bitnami/minideb:stretch

LABEL maintainer=rays3t
LABEL version="1.3.0"
LABEL description="A docker container for building sourcemod plugins (.sp), based on a minimalist debian/stretch. \
This is intended to be used in an CI environment like GitLab. \
It also adds a little wrapper script for the spcomp that abstracts the sourcemod libs from your plugin ones"

# Add x86 support and install required dependencies.
# According to https://wiki.alliedmods.net/Compiling_SourceMod_Plugins
RUN dpkg --add-architecture i386 && install_packages \
	lib32stdc++6 \
	libc6:i386 \
	wget \
	git

# Create a new builder group and a new user (as system user(-r), auto creating home directory(-m)) 
# then add it to the created group (-g)
RUN groupadd -r smbuild && \
	useradd -m -r -g smbuild smuser

# Copy the modified compiler script
COPY compile.sh /home/smuser/compile.sh

# Make the compiler script executable and create a global command for it
RUN chmod 755 /home/smuser/compile.sh && ln -s /home/smuser/compile.sh /usr/bin/spcomp

# Change the user
USER smuser

WORKDIR /home/smuser

# Pull the latest stable sourcemod version
RUN BASE_SM_DL_URL=http://www.sourcemod.net/smdrop/1.9 && \
	LATEST_SM_VERSION=`wget $BASE_SM_DL_URL/sourcemod-latest-linux -q -O -` && \
	echo Detected sourcemod version: $LATEST_SM_VERSION && \
	wget -qO sourcemod.tar.gz $BASE_SM_DL_URL/$LATEST_SM_VERSION

# Create the sourcemod directory and extract the downloaded archive into it
# This will create a sourcemod instance in "/home/smuser/sourcemod",
# that is ready for compiling code
RUN mkdir sourcemod && \
	tar xvzf sourcemod.tar.gz -C sourcemod


# Create the build directory
RUN mkdir /home/smuser/build

# Finally switch to that directory
WORKDIR /home/smuser/build
