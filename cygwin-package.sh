#!/bin/sh

# path to this script
SCRIPT_DIR=`cd \`dirname \$0\`; pwd`

# path to resource files that aren't part of cygwin or node (e.g. resolv.conf)
RESOURCE_DIR=${SCRIPT_DIR}/resource

# temporary directory where files will be gathered before being compressed
TEMP_DIR=${SCRIPT_DIR}/tmp

# path to the node directory root
NODE_DIR=`cd "\`git rev-parse --git-dir\`/.."; pwd`

# name and path for the compiled zip package (without extensions)
PACKAGE_NAME=`pwd`/nodejs-`git describe`-cygwin

# build node
cd "${NODE_DIR}"
#./configure
#make

# folder struction
mkdir -p \
    "${TEMP_DIR}"                \
    "${TEMP_DIR}/bin"            \
    "${TEMP_DIR}/etc"            \
    "${TEMP_DIR}/etc/terminfo/c" \
    "${TEMP_DIR}/home"           \
    "${TEMP_DIR}/node"           \
    "${TEMP_DIR}/node/bin"       \
    "${TEMP_DIR}/node/doc"           \
    "${TEMP_DIR}/node/lib"       \
    "${TEMP_DIR}/tmp"            \
    "${TEMP_DIR}/usr"

# helper command shell scripts
cd "${RESOURCE_DIR}"
cp -L --target-directory="${TEMP_DIR}" \
    bash.cmd            \
    node.cmd

# config files
cp -Lr "${RESOURCE_DIR}/etc"/* "${TEMP_DIR}/etc"

# node binaries
cp -L "${NODE_DIR}/node" "${TEMP_DIR}/node/bin/node.exe"
cp -Lr "${NODE_DIR}/bin"/* "${TEMP_DIR}/node/bin"

# node library and symbols
cp -L "${NODE_DIR}/build/default/"libnode* "${TEMP_DIR}/node/lib"

# node documentation
cp -Lr "${NODE_DIR}/doc/"* "${TEMP_DIR}/node/doc"

# cygwin binary utils
cd /bin
cp -L --target-directory="${TEMP_DIR}/bin" \
    bash.exe            \
    cat.exe             \
    chgrp.exe           \
    chmod.exe           \
    chown.exe           \
    cp.exe              \
    cygcheck.exe        \
    cygpath.exe         \
    cygrunsrv.exe       \
    d2u.exe             \
    date.exe            \
    diff.exe            \
    false.exe           \
    grep.exe            \
    groups              \
    gzip.exe            \
    id.exe              \
    less.exe            \
    ln.exe              \
    ls.exe              \
    mkdir.exe           \
    mkgroup.exe         \
    mkpasswd.exe        \
    mount.exe           \
    mv.exe              \
    nano.exe            \
    printenv.exe        \
    ps.exe              \
    pwd.exe             \
    rm.exe              \
    sed.exe             \
    sort.exe            \
    tail.exe            \
    tar.exe             \
    touch.exe           \
    umount.exe          \
    wc.exe

# cygwin shared libraries
cd /bin
cp -L --target-directory="${TEMP_DIR}/bin" \
    cygcrypt-0.dll      \
    cygcrypto-0.9.8.dll \
    cyggcc_s-1.dll      \
    cygiconv-2.dll      \
    cygintl-1.dll       \
    cygintl-2.dll       \
    cygintl-3.dll       \
    cygintl-8.dll       \
    cygminires.dll      \
    cygncurses-8.dll    \
    cygncurses-9.dll    \
    cygncurses-10.dll   \
    cygpcre.dll         \
    cygpcre-0.dll       \
    cygpopt-0.dll       \
    cygreadline7.dll    \
    cygssl-0.9.8.dll    \
    cygssp-0.dll        \
    cygstdc++-6.dll     \
    cygwin1.dll         \
    cygwrap-0.dll       \
    cygz.dll

# create zip archive
cd "${TEMP_DIR}"
rm -f "${PACKAGE_NAME}.zip" 
zip -r9q "${PACKAGE_NAME}.zip" .

# drop temp dir
rm -rf "${TEMP_DIR}"