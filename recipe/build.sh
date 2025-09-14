#!/bin/bash
set -ex
shopt -s globstar

./configure --prefix="$PREFIX" || (cat config.log; false)

make -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
  make check || (cat ./**/test-suite.log; exit 1)
fi
make install
