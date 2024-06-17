# Cross-compiling C++ code for Windows on Linux

In this example, we will cross-compile a simple C++ code for Windows on Linux using MinGW.

This has been tested on Ubuntu 23 / x64.

## Install necessary packages for cross-compiling and CMake

```bash
sudo apt update
sudo apt install mingw-w64 g++-mingw-w64-x86-64 cmake nasm
```

## Use the provided sources

- hello.cpp: A console application that prints "Hello, World!".
- hello_win.cpp: A Win32 application that shows a message box with "Hello, World!".
- CMake toolchain files:
    - x86_32-w64-mingw32.cmake: For 32-bit Windows.
    - x86_64-w64-mingw32.cmake: For 64-bit Windows.
- bld.sh: A build script (pass '32' or '64')
- routine32.asm/routine64.asm: Sample NASM files that will also be built and used  

## Dynamic linking

To enable dynamic linking, modify the CMake toolchain files by deleting the lines related to the C/CXX flags and the "-static" value.

If the executable searches for dynamic libraries in incorrect locations, adjusting the LD_LIBRARY_PATH environment variable to point to the directory with the dynamic libraries can resolve this issue.

```bash
find /usr -name libstdc++-6.dll
```

    /usr/lib/gcc/x86_64-w64-mingw32/12-posix/libstdc++-6.dll
    /usr/lib/gcc/x86_64-w64-mingw32/12-win32/libstdc++-6.dll
    /usr/lib/gcc/i686-w64-mingw32/12-posix/libstdc++-6.dll
    /usr/lib/gcc/i686-w64-mingw32/12-win32/libstdc++-6.dll

After finding the dynamic library, we can set the `LD_LIBRARY_PATH` environment variable to the directory containing the dynamic libraries.

```bash
export LD_LIBRARY_PATH=/usr/lib/gcc/x86_64-w64-mingw32/12-posix
```

Then we can run the executable.

Equally, we can copy the dynamic libraries to the directory containing the executable.

## Run the executables

```bash
wine build64/hello.exe
wine build32/hello.exe
```
