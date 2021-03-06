cmake_minimum_required(VERSION 3.9)
project(app VERSION 1.0 LANGUAGES C CXX)

# Tell CMake to call moc automaticly
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(PLUGIN_DIR ${CMAKE_BINARY_DIR}/plugins)

option(BUILD_SHARED_LIBS "Build all libraries as shared libraries instead of static" OFF)

set(PLATFORM "win" CACHE STRING "Which platform to build for: win, iOS")

configure_file(config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

find_package(Qt5 CONFIG REQUIRED COMPONENTS Quick Core Qml)

add_subdirectory(3rdparty)

add_subdirectory(qml)
add_subdirectory(plugins)
add_subdirectory(src)
