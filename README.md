
# RKAIQ Camera Engine

Two methods are provided on how to compile the RKAIQ Camera Engine

1. Cross compile on x86 workstation
2. Compile on ARM64 directly


## Cross Compile on x86 Workstation

### Compile 

The following instructions are for compiling on Debain 13 (Trixie)

Install AArch64 cross compiler
```
sudo apt install \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    cmake \
    ninja-build \
    build-essential
```

Make a build directory.
```
mkdir build-rk3576
cd build-rk3576
```

Configure for the Rockchip platform and ISP version.  In this case we are targetting `rk3576` and `ISP39`.
```
cmake .. \
    -G Ninja \
    -DCMAKE_TOOLCHAIN_FILE=../cmake/toolchains/rkaiq-debian-aarch64.cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DRKAIQ_TARGET_SOC=rk3576 \
    -DISP_HW_VERSION=-DISP_HW_V39 \
    -DRKAIQ_IQFILES_DIR=/etc/iqfiles \
    -DAIQ_BUILD_ARCH=aarch64 \
    -DARCH=aarch64
```

If you want to target `rk3588` with `ISP30` change the two parameters in the above configure.
```
-DRKAIQ_TARGET_SOC=rk3588 \
-DISP_HW_VERSION=-DISP_HW_V30
```

Build
```
ninja rkaiq rkaiq_3A_server
```

### Deploy

After completing the compile steps above, deploy on the SBC.

Copy the library and server files to the SBC.
```
rkaiq/all_lib/RelWithDebInfo/librkaiq.so 
rkaiq_3A_server/rkaiq_3A_server
```

Make sure the existing rkaiq_3A server is stopped.  On Radax OS do this with;
```
systemctl stop rkaiq_3A
```

Create a directory to put the compiled rkaiq files in on the SBC
```
mkdir /home/radxa/rkaiq
cd /home/radxa/rkaiq
```

Move the `librkaiq.so` and `rkaiq_3A_server` files into `/home/radxa/rkaiq`.

Run the rkaiq_3A server.
```
cd /home/radxa/rkaiq
LD_LIBRARY_PATH=/home/radxa/rkaiq rkaiq_3A_server
```



