#!/bin/bash

echo
echo "Clean Build Directory"
echo 

make clean && make mrproper

echo
echo "Issue Build Commands"
echo

mkdir -p out
export ARCH=arm64
export SUBARCH=arm64
export CLANG_PATH=~/Android_Build/Clang_Google/linux-x86/clang-r383902/bin
export CLANG_BIN_PATH=~/Android_Build/Clang_Google/linux-x86/clang-r383902/bin
export PATH=${CLANG_PATH}:${PATH}
export DTC_EXT=/home/miles/Downloads/DU_Tools/dtc-aosp
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=~/Android_Build/GCC_Google_Arm64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_COMPAT=~/Android_Build/GCC_Google_Arm32/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
# export LD_LIBRARY_PATH=~/Android_Build/Clang_Google/linux-x86/clang-r383902c/lib64:$LD_LIBRARY_PATH

export CLANG_AR=$CLANG_BIN_PATH/llvm-ar
export CLANG_CC=$CLANG_BIN_PATH/clang
export CLANG_LD=$CLANG_BIN_PATH/ld.lld
export CLANG_LDLTO=$CLANG_BIN_PATH/ld.lld
export CLANG_NM=$CLANG_BIN_PATH/llvm-nm

echo
echo "Set DEFCONFIG"
echo 
make CC=$CLANG_CC LD=$CLANG_LD LDLTO=$CLANG_LD AR=$CLANG_AR NM=$CLANG_NM OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out kirisakura_defconfig

echo
echo "Build The Good Stuff"
echo 

make CC=$CLANG_CC LD=$CLANG_LD LDLTO=$CLANG_LD AR=$CLANG_AR NM=$CLANG_NM OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=out -j24
