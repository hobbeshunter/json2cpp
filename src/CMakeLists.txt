cmake_minimum_required(VERSION 3.21)
project(
  json2cpp
  VERSION 0.0.1
  LANGUAGES CXX
)

set(projectPrefix JSON2CPP_)

if(NOT DEFINED CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 20)
endif()

set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g") # cmake default: "-g"
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O3 -g") # cmake default: "-O2 -g -DNDEBUG"
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG") # cmake default: "-O3 -DNDEBUG"

option(${projectPrefix}WITH_EXECUTABLE "Build the tool" ON)
message(STATUS "${projectPrefix}WITH_EXECUTABLE: ${${projectPrefix}WITH_EXECUTABLE}")

include(GNUInstallDirs)

add_subdirectory(lib)
if(${projectPrefix}WITH_EXECUTABLE)
  add_subdirectory(exe)
endif()

# project-wide wrapper
add_library(json2cpp INTERFACE)
target_link_libraries(json2cpp INTERFACE json2cpp::libjson2cpp)

add_library(json2cpp::json2cpp ALIAS json2cpp)
install(TARGETS json2cpp EXPORT json2cppTargets)

# local build
export(EXPORT json2cppTargets NAMESPACE json2cpp::)

# installation
install(
  EXPORT json2cppTargets
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/json2cpp
  NAMESPACE json2cpp::
)
