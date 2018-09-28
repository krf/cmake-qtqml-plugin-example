# This is 'myplugin' CMakeLists.txt file. 'myplugin' is application plugin.
# It means that it was created specailly for 'app' project and probably
# will be never used outside of it.
# If you're goind to create reusable plugin make sure to build it as
# separate project with proper install commands and CMake.config file.

add_library(myplugin MODULE
    myplugin.h
    myquickitem.h

    myplugin.cpp
    myquickitem.cpp

    qmldir

    plugin_common.qrc
)
if (PLATFORM STREQUAL "win")
    target_sources(myplugin PRIVATE win/plugin.qrc)
else()
    target_sources(myplugin PRIVATE ios/plugin.qrc)
endif()

target_link_libraries(myplugin
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
