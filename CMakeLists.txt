cmake_minimum_required(VERSION 3.21)
project(json2cpp-dev LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

set(projectPrefix JSON2CPP_)

set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g") # cmake default: "-g"
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O3 -g") # cmake default: "-O2 -g -DNDEBUG"
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG") # cmake default: "-O3 -DNDEBUG"

# Generate compile_commands.json to make it easier to work with clang based tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

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
add_subdirectory(fuzz_test)
