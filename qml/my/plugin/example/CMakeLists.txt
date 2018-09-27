# This is 'myplugin' CMakeLists.txt file. 'myplugin' is application plugin.
# It means that it was created specailly for 'app' project and probably
# will be never used outside of it.
# If you're goind to create reusable plugin make sure to build it as
# separate project with proper install commands and CMake.config file.

# 'myplugin' resource file. All files have 'plugin/' prefix
qt5_add_resources(PLUGIN_RESOURCES plugin.qrc)

add_library(
    myplugin
    MODULE

    myplugin.h
    myquickitem.h

    myplugin.cpp
    myquickitem.cpp

    qmldir

    ${PLUGIN_RESOURCES}     # Plugin resources file
)

set(CMAKE_AUTOMOC ON)
find_package(Qt5 REQUIRED COMPONENTS Quick Core Qml)

target_compile_features(
    myplugin
    PRIVATE
        cxx_auto_type
        cxx_generic_lambdas
)

target_compile_options(
    myplugin
    PRIVATE
        -Wall
        -Wextra
        -Wpedantic
)

target_link_libraries(
    myplugin
    PRIVATE
        Qt5::Core
        Qt5::Quick
        Qt5::Qml
)

# During plugin searching Qt will be looking for 'qmldir' file
# So we should place it next to our plugin lib.
add_custom_command(
    TARGET myplugin
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_LIST_DIR}/qmldir
        $<TARGET_FILE_DIR:myplugin>/qmldir
)