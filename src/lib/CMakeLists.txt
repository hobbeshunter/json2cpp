cmake_minimum_required(VERSION 3.19)

find_package(ValiJSON CONFIG)

add_library(libjson2cpp INTERFACE)

target_link_libraries(libjson2cpp INTERFACE ValiJSON::valijson)

target_include_directories(
  libjson2cpp INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include> $<INSTALL_INTERFACE:include>
)

set_target_properties(libjson2cpp PROPERTIES EXPORT_NAME libjson2cpp)
add_library(json2cpp::libjson2cpp ALIAS libjson2cpp)

# installation
install(TARGETS libjson2cpp EXPORT json2cppTargets)
install(DIRECTORY include/json2cpp TYPE INCLUDE)
