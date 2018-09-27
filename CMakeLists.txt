cmake_minimum_required(VERSION 3.9)
project(app VERSION 1.0 LANGUAGES CXX)

# Tell CMake to call moc automaticly
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(PLUGIN_DIR ${CMAKE_BINARY_DIR}/plugins)

find_package(Qt5 REQUIRED COMPONENTS Quick Core Qml)

add_subdirectory(qml)
add_subdirectory(plugins)
add_subdirectory(src)
