#!/bin/bash
set -ex

# Scopy path
# Scopy path
REPO_SRC=$1
if [ -z "$REPO_SRC" ]; then
	echo "Error: REPO_SRC is not set. Please provide the path to the Scopy repository."
	exit 1
fi
source $REPO_SRC/ci/macOS/macos_config.sh

build_scopy(){
	echo "### Building Scopy"
	ls -la $REPO_SRC
	pushd $REPO_SRC

	rm -rf $REPO_SRC/build
	mkdir -p $REPO_SRC/build
	cd $REPO_SRC/build
	cmake \
		-DCMAKE_LIBRARY_PATH="$STAGING_AREA_DEPS" \
		-DCMAKE_INSTALL_PREFIX="$STAGING_AREA_DEPS" \
		-DCMAKE_PREFIX_PATH="${STAGING_AREA_DEPS};${STAGING_AREA_DEPS}/lib/cmake;${STAGING_AREA_DEPS}/lib/pkgconfig;${STAGING_AREA_DEPS}/lib/cmake/gnuradio;${STAGING_AREA_DEPS}/lib/cmake/iio" \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DCMAKE_VERBOSE_MAKEFILE=ON \
		-DCMAKE_STAGING_PREFIX="$STAGING_AREA_DEPS" \
		-DCMAKE_EXE_LINKER_FLAGS="-L${STAGING_AREA_DEPS}/lib" \
		-DENABLE_TESTING=OFF \
		../
	CFLAGS=-I${STAGING_AREA_DEPS}/include LDFLAGS=-L${STAGING_AREA_DEPS}/lib make ${JOBS}
	otool -l ./Scopy.app/Contents/MacOS/Scopy
	otool -L ./Scopy.app/Contents/MacOS/Scopy
	popd
}

build_scopy
