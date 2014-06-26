
set(CMAKE_SYSTEM_NAME Generic)

set(PROJECT_ROOT "/Users/anshulrouthu/Workspace/hello_teensy")
set(PLATFORM_SDK_PATH "${PROJECT_ROOT}/Arduino.app/Contents/Resources/Java")

set(COMPILE_FLAGS "" CACHE STRING "Additional Compiler Flags")
set(MCU "cortex-m4" CACHE STRING "Processor Type")
set(CPU_SPEED "48000000" CACHE STRING "Frequency")
set(PORT "/dev/tty.usbmodem1421" CACHE STRING "USB Port")
set(PORT_SPEED "115200" CACHE STRING "Baud Rate")

find_program(PLATFORM_CC NAMES arm-none-eabi-gcc PATHS ${PLATFORM_SDK_PATH}/hardware/tools/arm-none-eabi/bin NO_DEFAULT_PATH)
find_program(PLATFORM_CXX NAMES arm-none-eabi-g++ PATHS ${PLATFORM_SDK_PATH}/hardware/tools/arm-none-eabi/bin NO_DEFAULT_PATH)
find_program(PLATFORM_OBJCOPY NAMES arm-none-eabi-objcopy PATHS ${PLATFORM_SDK_PATH}/hardware/tools/arm-none-eabi/bin NO_DEFAULT_PATH)
find_program(PLATFORM_OBJDUMP NAMES arm-none-eabi-objdump PATHS ${PLATFORM_SDK_PATH}/hardware/tools/arm-none-eabi/bin NO_DEFAULT_PATH)
find_program(PLATFORM_RANLIB NAMES arm-none-eabi-ranlib PATHS ${PLATFORM_SDK_PATH}/hardware/tools/arm-none-eabi/bin NO_DEFAULT_PATH)
find_program(PLATFORM_LD NAMES arm-none-eabi-ld PATHS ${PLATFORM_SDK_PATH}/hardware/tools/arm-none-eabi/bin NO_DEFAULT_PATH)

# Compiler suite specification
set(CMAKE_C_COMPILER ${PLATFORM_CC})
set(CMAKE_CXX_COMPILER ${PLATFORM_CXX})
set(CONFIGURE_OBJCOPY ${PLATFORM_OBJCOPY})
set(CONFIGURE_OBJDUMP ${PLATFORM_OBJDUMP})
set(CONFIGURE_RANLIB ${PLATFORM_RANLIB})
set(CONFIGURE_LINKER ${PLATFORM_LD})

set(PLATFORM_LIBS m arm_cortexM4l_math)
set(CMAKE_EXE_LINKER_FLAGS_INIT "-Os -Wl,--gc-sections -mcpu=${MCU} -mthumb -T${PLATFORM_SDK_PATH}/hardware/teensy/cores/teensy3/mk20dx128.ld")
set(CMAKE_CXX_FLAGS "-std=gnu++0x -felide-constructors -fno-exceptions -fno-rtti" CACHE STRING "Flags used by the compiler during all build types.")

# Find Arduino source files.
file(GLOB_RECURSE PLATFORM_CORE_SRC 
	${PLATFORM_SDK_PATH}/hardware/teensy/cores/teensy3/*.c
	${PLATFORM_SDK_PATH}/hardware/teensy/cores/teensy3/*.cpp
	)

add_definitions(-mcpu=${MCU} -DF_CPU=${CPU_SPEED} -DUSB_SERIAL -DLAYOUT_US_ENGLISH -D__MK20DX128__ -DARDUINO=105 -DTEENSYDUINO=118)
add_definitions(-Wall -g -Os -mthumb -nostdlib -MMD)
add_definitions(-ffunction-sections -fdata-sections)

set(PLATFORM_INC_DIR ${PLATFORM_SDK_PATH}/hardware/teensy/cores/teensy3)
find_program(BOARD_LOADER NAMES teensy_post_compile PATHS ${PLATFORM_SDK_PATH}/hardware/tools NO_DEFAULT_PATH)
find_program(BOARD_REBOOT NAMES teensy_reboot PATHS ${PLATFORM_SDK_PATH}/hardware/tools NO_DEFAULT_PATH)
set(LOADER_FLAGS -file=${PROJECT_NAME} -path=${CMAKE_BINARY_DIR} -tools=${PLATFORM_SDK_PATH}/hardware/tools)