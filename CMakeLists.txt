
cmake_minimum_required(VERSION 2.8)
project(blink)

set(PROJECT_ROOT "/Users/anshulrouthu/Workspace/hello_teensy")
set(PLATFORM_SDK_PATH "${PROJECT_ROOT}/Arduino.app/Contents/Resources/Java/")

# Set own source files
set(SRC_FILES ${PROJECT_NAME}/${PROJECT_NAME}.cpp)

# User libraries
set(USER_LIBS_DIR "${PROJECT_ROOT}/libraries" CACHE STRING "User Library Dir")
set(USER_LIBS test  CACHE STRING "User installed libraries")

# Core libraries
set(CORE_LIBS_DIR "${PLATFORM_SDK_PATH}/libraries" CACHE STRING "Core Library Dir")
set(CORE_LIBS SPI CACHE STRING "Core libraries")

# Library incudes for user space libraries
foreach(user_lib ${USER_LIBS})
file(GLOB USER_LIB_INC
	${USER_LIB_INC}
	${USER_LIBS_DIR}/${user_lib}
	)
endforeach()

# Library includes for core libraries
foreach(core_lib ${CORE_LIBS})
file(GLOB CORE_LIB_INC
	${CORE_LIB_INC}
	${CORE_LIBS_DIR}/${core_lib}
	)
endforeach()

# Src files for user libraries
foreach(user_lib ${USER_LIBS})
file(GLOB USER_LIB_SRC
	${USER_LIB_SRC}
	${USER_LIBS_DIR}/${user_lib}/*.c
	${USER_LIBS_DIR}/${user_lib}/*.cpp
	)
endforeach()

# Src files for core libraries
foreach(core_lib ${CORE_LIBS})
file(GLOB CORE_LIB_SRC
	${CORE_LIB_SRC}
	${CORE_LIBS_DIR}/${core_lib}/*.c
	${CORE_LIBS_DIR}/${core_lib}/*.cpp
	)
endforeach()

# Include directories
include_directories(
	${CMAKE_CURRENT_SOURCE_DIR}
    ${PLATFORM_INC_DIR}
	${USER_LIB_INC}
	${CORE_LIB_INC}
	${AR_AVR_INC}
	${AR_AVRGCC_INC}
	)
	
# Main executable built
add_executable(${PROJECT_NAME} ${PLATFORM_CORE_SRC} ${SRC_FILES} ${USER_LIB_SRC} ${CORE_LIB_SRC})
foreach(lib ${PLATFORM_LIBS})
    target_link_libraries (${PROJECT_NAME} ${lib})
endforeach()

# Custom target for uploading build binary file
add_custom_target(upload 
	COMMAND ${CMAKE_OBJCOPY} -j .text -j .data -O ihex ${PROJECT_NAME} ${PROJECT_NAME}.hex
	COMMAND ${BOARD_LOADER} ${LOADER_FLAGS}
	COMMAND ${BOARD_REBOOT}
	DEPENDS ${PROJECT_NAME}
	)