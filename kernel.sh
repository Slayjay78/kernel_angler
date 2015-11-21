#!/bin/bash
# Copyright (C) 2015 Rusty
# credits to sparksco for the SaberMod kernel buildscript as base
# Build Script. Use bash to run this script
export MANUFACTURER=huawei;
export DEVICE=angler;

# GCC
export CC=$HOST_CC;
export CXX=$HOST_CXX;
export USE_CCACHE=1

# Source Directory PATH
#export DIRSRC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )";


# Kernel Source PATH
#export KERNELSRC=$DIRSRC;

# Target gcc version
export TARGET_GCC=4.9;



export AARCH64_LINUX_ANDROID_TOOLCHAIN=../prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9;

#export PATH=$AARCH64_LINUX_ANDROID_TOOLCHAIN/aarch64-linux-android/bin:$AARCH64_LINUX_ANDROID_TOOLCHAIN/bin:$PATH;

 echo 'Kernel buid with ' $AARCH64_LINUX_ANDROID_TOOLCHAIN;

# Build ID
export LOCALVERSION="-RustedK"
export KBUILD_BUILD_USER=Rusty
export KBUILD_BUILD_HOST="Ishigh"

# Cross compile with arm64
export ARCH=arm64;
export CCOMPILE=$CROSS_COMPILE;
export CROSS_COMPILE=$AARCH64_LINUX_ANDROID_TOOLCHAIN/bin/aarch64-linux-android-;

# Start the build
echo "";
echo "Starting the kernel build";
echo "";
if [ -e ./arch/arm64/boot/Image.gz-dtb ] ;
then
    rm ./arch/arm64/boot/Image.gz-dtb;
fi;

make angler_defconfig;
time make -j8;

if [ -e ./arch/arm64/boot/Image.gz-dtb ] ;
then
 cp ./arch/arm64/boot/Image.gz-dtb -f ../device/huawei/angler-kernel/Image.gz-dtb;
 echo "Kernel build finished, Continuing with ROM build";
 echo "";
else
    echo "";
    echo "error detected in kernel build, now exiting";
    exit 1;
fi;
