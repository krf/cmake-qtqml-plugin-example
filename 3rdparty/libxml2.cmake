# Copyright 2017 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
  list(APPEND LIBXML2_BUILD_BYPRODUCTS ${LIBXML2_INSTALL_DIR}/lib/lib${lib}.a)

  set(target ThirdParty::${lib})
  add_library(${target} STATIC IMPORTED GLOBAL)
  set_target_properties(${target} PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${LIBXML2_INCLUDE_DIRS}"
      IMPORTED_LOCATION ${LIBXML2_INSTALL_DIR}/lib/lib${lib}.a
  )
  add_dependencies(${target} ${LIBXML2_TARGET})
endforeach()

ExternalProject_Add(${LIBXML2_TARGET}
    PREFIX ${LIBXML2_TARGET}
    SOURCE_DIR ${LIBXML2_SRC_DIR}
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${LIBXML2_SRC_DIR}/autogen.sh
        --without-python
        --without-zlib
        --without-lzma
        --prefix=${LIBXML2_INSTALL_DIR}
        ${extra_configure_params}
        CC=${CMAKE_C_COMPILER}
        CXX=${CMAKE_CXX_COMPILER}
        CFLAGS=${LIBXML2_CFLAGS}
        CXXFLAGS=${LIBXML2_CXXFLAGS}
    BUILD_COMMAND make
    INSTALL_COMMAND make install
    BUILD_BYPRODUCTS ${LIBXML2_BUILD_BYPRODUCTS}
)
