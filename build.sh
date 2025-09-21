export CPM_SOURCE_CACHE=$HOME/.cache/CPM

if [ ! -d build ]; then
  cmake -S . -B build -G Ninja \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
    -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_REPO/clang-cl-msvc.cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCPM_SOURCE_CACHE=$HOME/.cache/CPM
fi
cmake --build build -j$(nproc)

cp build/flafy.showcase.pdb /home/flafy/Games/data/windows/geometry-dash
