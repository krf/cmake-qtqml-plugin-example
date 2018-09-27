add_library(testplugin MODULE testplugin.cpp)
target_link_libraries(testplugin PRIVATE Qt5::Core)
enable_plugin(testplugin)
