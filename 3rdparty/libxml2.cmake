include (ExternalProject)

set(LIBXML2_TARGET libxml2)
set(LIBXML2_SRC_DIR "${CMAKE_CURRENT_LIST_DIR}/libxml2")
set(LIBXML2_INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}/${LIBXML2_TARGET}/install")

set(LIBXML2_INCLUDE_DIRS ${LIBXML2_INSTALL_DIR}/include/libxml2)
file(MAKE_DIRECTORY ${LIBXML2_INCLUDE_DIRS}) # work-around issue in CMake

set(extra_configure_params)
if (BUILD_SHARED_LIBS)
    list(APPEND extra_configure_params --enable-static=no)
else()
    list(APPEND extra_configure_params --enable-shared=no)
endif()

list(APPEND LIBXML2_LIBRARIES xml2)

foreach(lib IN LISTS LIBXML2_LIBRARIES)
  if (MSVC)
      set(implib ${LIBXML2_INSTALL_DIR}/lib/lib${lib}.lib)
      set(libpath ${LIBXML2_INSTALL_DIR}/lib/lib${lib}_a.lib)
      set(deps wsock32 ws2_32)
  else()
      set(implib "")
      set(libpath ${LIBXML2_INSTALL_DIR}/lib/lib${lib}.a)
      set(deps)
  endif()

  set(target ThirdParty::${lib})
  add_library(${target} STATIC IMPORTED GLOBAL)
  set_target_properties(${target} PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${LIBXML2_INCLUDE_DIRS}"
      IMPORTED_IMPLIB "${implib}"
      IMPORTED_LOCATION "${libpath}"
      IMPORTED_LINK_INTERFACE_LIBRARIES "${deps}"
  )
  add_dependencies(${target} ${LIBXML2_TARGET})
  list(APPEND LIBXML2_BUILD_BYPRODUCTS ${libpath})
endforeach()

if (MSVC)
    file(TO_NATIVE_PATH ${LIBXML2_INSTALL_DIR} install_dir)
    set(configure_command cscript configure.js
            compiler=msvc prefix=${install_dir} debug=yes iconv=no)
    set(build_command nmake /f Makefile.msvc)
    set(install_command nmake /f Makefile.msvc install)
    set(extra_params BINARY_DIR ${LIBXML2_SRC_DIR}/win32)
else()
    set(configure_command ${LIBXML2_SRC_DIR}/autogen.sh
            --without-python
            --without-zlib
            --without-lzma
            --prefix=${LIBXML2_INSTALL_DIR}
            ${extra_configure_params}
            CC=${CMAKE_C_COMPILER}
            CXX=${CMAKE_CXX_COMPILER}
            CFLAGS=${LIBXML2_CFLAGS}
            CXXFLAGS=${LIBXML2_CXXFLAGS}
    )
    set(build_command make)
    set(install_command make install)
    set(extra_params)
endif()

ExternalProject_Add(${LIBXML2_TARGET}
    PREFIX ${LIBXML2_TARGET}
    SOURCE_DIR ${LIBXML2_SRC_DIR}
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${configure_command}
    BUILD_COMMAND ${build_command}
    INSTALL_COMMAND ${install_command}
    BUILD_BYPRODUCTS ${LIBXML2_BUILD_BYPRODUCTS}
    ${extra_params}
)
