#!/bin/bash

#here using toolchain - Uber-8.0 code
echo Setting ARCH and CROSS COMPILER

export KERNELNAME="TestKernel"
export ARCH=arm64 && export SUBARCH=arm64
export CROSS_COMPILE=$HOME/Experimental/ToolChain/bin/aarch64-linux-gnu-
export MAKE_TYPE="Treble"

echo Done

#build
echo BUILD Preparation
 
make clean
make mrproper
make -C $(pwd) O=output santoni_treble_defconfig
#SELINUX_DEFCONFIG=selinux_defconfig

make -j4 -C $(pwd) O=output

#make $(pwd)/arch/arm64/configs/santoni_treble_defconfig
#make -j$(nproc --all)


echo zipping up kernel
cp -v "$(pwd)/output/arch/arm64/boot/Image.gz-dtb" "$(pwd)/AnyKernel3/Image.gz-dtb";
cp -v "$(pwd)/output/arch/arm64/boot/dts/qcom/msm8940-pmi8950-qrd-sku7_S88536AA2-treble.dtb" "$(pwd)/AnyKernel3/treble/t.dtb";

cd AnyKernel3
zip -r9 TestKernel Image.gz-dtb META-INF tools treble anykernel.sh

#cd AnyKernel2
#zip -r9 TestKernel zImage META-INF modules patch ramdisk tools treble anykernel.sh
 
echo Successful
