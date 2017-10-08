#!/bin/bash

# Path the the compiler executable
SP_COMP_EXE=/home/smuser/sourcemod/addons/sourcemod/scripting/spcomp

# Working directory for custom plugins
BUILD_DIR=$CI_PROJECT_DIR

# Dir for compiled plugins
COMPILE_DIR=$BUILD_DIR/compiled


additional_params=$1
echo "Using additional params: $additional_params"

function compile_failed() {
        echo "Seem like a script does not compile, check error out from spcomp above for more details"
        exit 1;
}

# Change to the root of the sourcemod scripting directory so sourcemod can find all its include dependencies

echo "Compiled smx files going to: $COMPILE_DIR"

# Check if the build dir contains an include folder
# THis is not required, but the user should see a message, if it is missing
if [ ! -d $BUILD_DIR/include ]; then
	echo "INFO: Your build directory ($BUILD_DIR) does not contain an include folder. \
This means if your plugin has non-standard (not included in sourcemod) dependencies, these cannot be loaded"
fi

test -e $COMPILE_DIR || mkdir $COMPILE_DIR

dir_before=$(pwd)
cd $BUILD_DIR
for sourcefile in *.sp
do
	# Guard to prevent processing *.sp when no files in directory
	if [ ! -f "$sourcefile" ]; then
		echo "No files found for compilation"
		break;
	fi
	smxfile="`echo $sourcefile | sed -e 's/\.sp$/\.smx/'`"
	echo -e "Compiling $sourcefile ..."
	$SP_COMP_EXE $sourcefile -o$COMPILE_DIR/$smxfile -i$BUILD_DIR/include $additional_params
	RETVAL=$?
	if [ $RETVAL -ne 0 ]; then
		compile_failed
	fi
done
cd $dir_before

