set(CMAKE_CXX_COMPILER /usr/bin/arm-none-eabi-g++)
set(CMAKE_C_COMPILER /usr/bin/arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER /usr/bin/arm-none-eabi-gcc)
set(CMAKE_OBJCOPY /usr/bin/arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP /usr/bin/arm-none-eabi-objdump)
set(CMAKE_C_OUTPUT_EXTENSION .o)
set(CMAKE_SYSTEM_PROCESSOR cortex-m7)
set(TOOLCHAIN arm-none-eabi)
set(TOOLCHAIN_PREFIX "/usr")
set(TOOLCHAIN_BIN_DIR ${TOOLCHAIN_PREFIX}/bin)
set(TOOLCHAIN_INC_DIR ${TOOLCHAIN_PREFIX}/${TOOLCHAIN}/include)
set(TOOLCHAIN_LIB_DIR ${TOOLCHAIN_PREFIX}/${TOOLCHAIN}/lib)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
# set(OBJECT_GEN_FLAGS "-O0 -mthumb -fno-builtin -Wall -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs")
set(OBJECT_GEN_FLAGS "-O0 -Wall -fdata-sections -ffunction-sections -fno-builtin -fomit-frame-pointer -fasm")
set(ARM_TOOLCHAIN_COMMON_FLAGS "-mthumb -mtune=cortex-m7 -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-d16 -Wno-unknown-pragmas-marm ${OBJECT_GEN_FLAGS}")
set(WARNINGS "-Wall -Wno-attributes -Wno-strict-aliasing -Wno-maybe-uninitialized -Wno-missing-attributes -Wno-stringop-overflow")
foreach (LANG in ITEMS C CXX ASM)
    set(CMAKE_${LANG}_FLAGS_INIT "${ARM_TOOLCHAIN_COMMON_FLAGS} ${WARNINGS} -ggdb")
    set(CMAKE_${LANG}_LINK_FLAGS "-W")
    if(IS_IN_TRY_COMPILE)
        set(CMAKE_${LANG}_LINK_FLAGS "${CMAKE_${LANG}_LINK_FLAGS} -nostdlib")
    endif()
endforeach ()

set(CMAKE_EXE_LINKER_FLAGS "${ARM_TOOLCHAIN_COMMON_FLAGS} -Wl,--gc-sections --specs=nano.specs --specs=nosys.specs -Wl,-Map=${CMAKE_PROJECT_NAME}.map" CACHE INTERNAL "Linker options")
# set(CMAKE_EXE_LINKER_FLAGS "-mthumb -marm -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-d16 -Wl,--gc-sections --specs=nano.specs --specs=nosys.specs" CACHE INTERNAL "Linker options")
set(CMAKE_C_FLAGS_DEBUG "-Og -g" CACHE INTERNAL "C Compiler options for debug build type")
set(CMAKE_CXX_FLAGS_DEBUG "-Og -g -fno-exceptions -fno-rtti -Wno-register" CACHE INTERNAL "C++ Compiler options for debug build type")
set(CMAKE_ASM_FLAGS_DEBUG "-g" CACHE INTERNAL "ASM Compiler options for debug build type")
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "" CACHE INTERNAL "Linker options for debug build type")

set(CMAKE_C_FLAGS_RELEASE "-Os -flto" CACHE INTERNAL "C Compiler options for release build type")
set(CMAKE_CXX_FLAGS_RELEASE "-Os -flto" CACHE INTERNAL "C++ Compiler options for release build type")
set(CMAKE_ASM_FLAGS_RELEASE "" CACHE INTERNAL "ASM Compiler options for release build type")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "-flto" CACHE INTERNAL "Linker options for release build type")