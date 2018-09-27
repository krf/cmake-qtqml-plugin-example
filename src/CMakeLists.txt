# We're using ${PROJECT_NAME} for target name but it's not necessary
add_executable(${PROJECT_NAME}
    main.cpp        # Our example project consists only of one .cpp file

    qml/app.qrc
)
target_compile_features(${PROJECT_NAME}
    PRIVATE
        cxx_auto_type
        cxx_generic_lambdas
)
if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    target_compile_options(${PROJECT_NAME}
        PRIVATE
            -Wall
            -Wextra
            -Wpedantic
    )
endif()
target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt5::Core
        Qt5::Quick
        Qt5::Qml

)

add_executable(libxml2_test_tree2
    libxml2_test_tree2.c
)
target_link_libraries(libxml2_test_tree2 PRIVATE ThirdParty::xml2)
