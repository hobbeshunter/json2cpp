cmake_minimum_required(VERSION 3.21)
project(json2cpp-dev LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

set(projectPrefix JSON2CPP_)

# make sure that the file is being used as an entry point
include(modern_project_structure)
ensure_entry_point()

# use ccache if available
include(ccache)
enable_ccache(BASE_DIR ${PROJECT_SOURCE_DIR})

# set restrictive compilation warnings
include(warnings)
set_warnings()

# add clang-tidy
if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  include(static_analysis)
  enable_clang_tidy()
endif()

add_subdirectory(src)

# add unit tests
enable_testing()
add_subdirectory(test)
