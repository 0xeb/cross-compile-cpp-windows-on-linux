cmake_minimum_required(VERSION 3.20)

project(hello C CXX ASM_NASM)

# Enable NASM for assembly files
enable_language(ASM_NASM)

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(ASM_SOURCE routine64.asm)
else()
    set(ASM_SOURCE routine32.asm)
endif()

add_executable(hello hello.cpp routine.h ${ASM_SOURCE})
add_executable(hello_win WIN32 hello_win.cpp)

# Set properties for NASM source files
set_source_files_properties(${ASM_SOURCE} PROPERTIES LANGUAGE ASM_NASM)
