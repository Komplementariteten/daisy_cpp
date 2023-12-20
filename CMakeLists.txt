cmake_minimum_required(VERSION 3.12)

set(NAME daisy_cpp)
include(arm-none-eabi.cmake)
include(lib_daisy.cmake)
include(black_magic_probe.cmake)

project(${NAME} C CXX ASM)
set(CMAKE_CXX_STANDARD 20)
add_executable(${NAME} main.cpp)
target_link_libraries(${NAME} libdaisy.a)
