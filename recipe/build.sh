#!/bin/bash

if [[ ${CC} =~ .*gcc.* && ${c_compiler} =~ .*toolchain.* ]]; then
    export CFLAGS="${CFLAGS} -std=c99 "
fi

# export CFLAGS="-march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -pipe -I$PREFIX/include -fdebug-prefix-map=${SRC_DIR}=/usr/local/src/conda/${PKG_NAME}-${PKG_VERSION} -fdebug-prefix-map=${PREFIX}=/usr/local/src/conda-prefix"
# export CPPFLAGS="-DNDEBUG -D_FORTIFY_SOURCE=2 -O2"
# export CFLAGS="-march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-all -fno-plt -Og -g -Wall -Wextra -fvar-tracking-assignments -ffunction-sections -pipe -I${PREFIX}/include -fdebug-prefix-map=${SRC_DIR}=/usr/local/src/conda/${PKG_NAME}-${PKG_VERSION} -fdebug-prefix-map=${PREFIX}=/usr/local/src/conda-prefix"
# export CPPFLAGS="-D_DEBUG -D_FORTIFY_SOURCE=2 -Og"

# export CPPFLAGS="${CPPFLAGS//-DNDEBUG/}"
# export CFLAGS="${CFLAGS} --save-temps"

# export LDFLAGS="-Wl,-O2 -Wl,--sort-common -Wl,--as-needed -Wl,-z,relro -Wl,-z,now -Wl,--disable-new-dtags -Wl,--gc-sections -Wl,-rpath,${PREFIX}/lib -L${PREFIX}/lib"

# Building with conda-forge gmp causes a strange segfault.
# Using mini-gmp seems to solve the issue and gnutls still works

./configure --prefix="${PREFIX}" \
    --libdir="${PREFIX}/lib/" \
    --with-lib-path="${PREFIX}/lib/" \
    --disable-assembler \
    --enable-mini-gmp || { cat config.log; exit 1; }
make V=1 -j1
make install -j1
make check
