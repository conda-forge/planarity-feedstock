#!/bin/bash
set -ex

./configure --prefix="$PREFIX" || (cat config.log; false)

[[ "$target_platform" == "win-64" ]] && patch_libtool

make -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
  make check
fi
make install
