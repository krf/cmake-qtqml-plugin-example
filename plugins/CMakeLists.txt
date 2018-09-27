function(enable_plugin target)
    set_target_properties(${target} PROPERTIES
        LIBRARY_OUTPUT_DIRECTORY ${PLUGIN_DIR}
    )
endfunction()

add_subdirectory(testplugin)
