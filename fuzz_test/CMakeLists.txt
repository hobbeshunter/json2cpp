# A fuzz test runs until it finds an error. This particular one is going to rely on libFuzzer.
#

option(${projectPrefix}ENABLE_FUZZ_TESTS "Enable fuzzing tests" OFF)
message(STATUS "${projectPrefix}ENABLE_FUZZ_TESTS: ${${projectPrefix}ENABLE_FUZZ_TESTS}")

if(NOT ${projectPrefix}ENABLE_FUZZ_TESTS)
  return()
endif()

include(lib_fuzzer)

json2cpp_check_libfuzzer_support(LIBFUZZER_SUPPORTED)
if(NOT LIBFUZZER_SUPPORTED)
  message(STATUS "Fuzzing is not supported!")
  return()
endif()

find_package(fmt)

add_executable(fuzz_tester fuzz_tester.cpp)
target_link_libraries(fuzz_tester PRIVATE json2cpp::libjson2cpp fmt::fmt -coverage -fsanitize=fuzzer,undefined,address)
target_compile_options(fuzz_tester PRIVATE -g -O1 -fsanitize=fuzzer,undefined,address)

# Allow short runs during automated testing to see if something new breaks
set(FUZZ_RUNTIME
    10
    CACHE STRING "Number of seconds to run fuzz tests during ctest run"
) # Default of 10 seconds

add_test(NAME fuzz_tester_run COMMAND fuzz_tester -max_total_time=${FUZZ_RUNTIME})
