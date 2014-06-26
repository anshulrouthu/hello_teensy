
set(CMAKE_SYSTEM_NAME Generic)

set(PROJECT_ROOT "/Users/anshulrouthu/Workspace/hello_teensy")
set(PLATFORM_SDK_PATH "${PROJECT_ROOT}/Arduino.app/Contents/Resources/Java")

set(PROGRAMMER "stk500v2" CACHE STRING "Programmer Type")
set(COMPILE_FLAGS "" CACHE STRING "Additional Compiler Flags")
set(MCU "atmega2560" CACHE STRING "Processor Type")
set(CPU_SPEED "16000000" CACHE STRING "Frequency")
set(PORT "/dev/tty.usbmodem1421" CACHE STRING "USB Port")
set(PORT_SPEED "115200" CACHE STRING "Baud Rate")
set(PIN_VARIANT "mega" CACHE STRING "Pin Selection Variant. Either standard, mega, leonardo, eightanaloginputs")

find_program(PLATFORM_CC NAMES avr-gcc PATHS ${PLATFORM_SDK_PATH}/hardware/tools/avr/bin NO_DEFAULT_PATH)
find_program(PLATFORM_CXX NAMES avr-g++ PATHS ${PLATFORM_SDK_PATH}/hardware/tools/avr/bin NO_DEFAULT_PATH)
find_program(PLATFORM_OBJCOPY NAMES avr-objcopy PATHS ${PLATFORM_SDK_PATH}/hardware/tools/avr/bin NO_DEFAULT_PATH)
find_program(PLATFORM_OBJDUMP NAMES avr-objdump PATHS ${PLATFORM_SDK_PATH}/hardware/tools/avr/bin NO_DEFAULT_PATH)
find_program(PLATFORM_RANLIB NAMES avr-ranlib PATHS ${PLATFORM_SDK_PATH}/hardware/tools/avr/bin NO_DEFAULT_PATH)
find_program(PLATFORM_LD NAMES avr-ld PATHS ${PLATFORM_SDK_PATH}/hardware/tools/avr/bin NO_DEFAULT_PATH)

# Compiler suite specification
set(CMAKE_C_COMPILER ${PLATFORM_CC})
set(CMAKE_CXX_COMPILER ${PLATFORM_CXX})
set(CONFIGURE_OBJCOPY ${PLATFORM_OBJCOPY})
set(CONFIGURE_OBJDUMP ${PLATFORM_OBJDUMP})
set(CONFIGURE_RANLIB ${PLATFORM_RANLIB})
set(CONFIGURE_LINKER ${PLATFORM_LD})

set(CMAKE_EXE_LINKER_FLAGS_INIT "-Os -Wl,--gc-sections -mmcu=${MCU}")
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")   # remove -rdynamic for C
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "") # remove -rdynamic for CXX

# Find Arduino source files.
file(GLOB_RECURSE PLATFORM_CORE_SRC 
	${PLATFORM_SDK_PATH}/hardware/arduino/cores/arduino/*.c
	${PLATFORM_SDK_PATH}/hardware/arduino/cores/arduino/*.cpp
	)

add_definitions(-mmcu=${MCU} -DF_CPU=${CPU_SPEED})
add_definitions(-c -g -Os -Wall)
add_definitions(-fno-exceptions -ffunction-sections -fdata-sections)

set(PLATFORM_INC_DIR ${PLATFORM_SDK_PATH}/hardware/arduino/cores/arduino ${PLATFORM_SDK_PATH}/hardware/arduino/variants/${PIN_VARIANT} )

find_program(BOARD_LOADER NAMES avrdude PATHS ${PLATFORM_SDK_PATH}/hardware/tools/avr/bin NO_DEFAULT_PATH)
file(GLOB_RECURSE LOADER_CFG ${PLATFORM_SDK_PATH}/**/avrdude.conf)
set(LOADER_FLAGS -C${LOADER_CFG} -F -p${MCU} -c${PROGRAMMER} -P${PORT} -b${PORT_SPEED} -D -Uflash:w:${PROJECT_NAME}.hex:i)