#!/bin/bash

echo
echo "Clean Build Directory"
echo 

#make clean && make mrproper
rm -rf ./out_lld

echo
echo "Issue Build Commands"
echo

mkdir -p out_lld
export ARCH=arm64
export SUBARCH=arm64
BASE_PATH=/home/miles/Android_Build/Clang_Google/linux-x86/
EXT_UTILS=$BASE_PATH/wahoo-kernel-tools/bin
export CLANG_PATH_LIB=$BASE_PATH/clang-r416183/lib64
export CLANG_PATH=$BASE_PATH/clang-r416183/bin
export PATH=${CLANG_PATH}:${EXT_UTILS}:${PATH}
export DTC_EXT=$EXT_UTILS/dtc-aosp

export KMI_GENERATION=0
export CROSS_COMPILE=$BASE_PATH/gas-linux-x86/aarch64-linux-gnu-
#export CROSS_COMPILE_ARM32=$BASE_PATH/gas-linux-x86/arm-linux-gnueabi-
#export CROSS_COMPILE_COMPAT=$CROSS_COMPILE_ARM32
export LLVM=1

LD_LIBRARY_PATH=$CLANG_PATH_LIB:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

export CC=$CLANG_PATH/clang
export LD=$CLANG_PATH/ld.lld
export CLANG_TRIPLE=aarch64-linux-gnu-

echo "Generating binary conversions"
#cd binaries
#./convert
#cd ..

echo
echo "Set DEFCONFIG"
echo 

make O=out_lld kirisakura_defconfig


echo
echo "Build The Good Stuff"
echo 

make O=out_lld -j24
