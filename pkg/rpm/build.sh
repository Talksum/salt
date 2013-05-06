#!/bin/sh

# this script is intended to be run on a build host,
# from within the directory where it's located

# we could try finding the specfile in the local dir,
# but making it an explicitly defined variable is probably safer
SPECFILE=salt.spec

# make sure the user's build environment has the proper directories
which rpmdev-setuptree >/dev/null 2>&1
if [ $? -ne 0 ]; then
echo "this script needs rpmdevtools installed"
    exit 1
fi
rpmdev-setuptree
if [ $? -ne 0 ]; then
echo "setting up rpmbuild directories failed, aborting"
    exit 1
fi

# put the spec file, helper files, and source tarball where they need to go
cp $SPECFILE ~/rpmbuild/SPECS/
NAME=`grep '^Name:' $SPECFILE | awk '{print $2}'`
VERSION=`grep '^Version:' $SPECFILE | awk '{print $2}'`

cp $NAME-{master,minion,syndic,defaults} ~/rpmbuild/SOURCES/

# note that an existing tarball (of the same version) will be clobbered!
tar cfz ~/rpmbuild/SOURCES/$NAME-$VERSION.tar.gz -C ../../ --exclude-vcs .

# now build it
rpmbuild -ba ~/rpmbuild/SPECS/$SPECFILE
