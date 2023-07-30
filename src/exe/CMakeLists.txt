
add_executable(json2cppexe src/main.cpp src/json2cpp.cpp)

target_include_directories(
  json2cppexe INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

target_link_libraries(json2cppexe PRIVATE json2cpp::libjson2cpp)

find_package(fmt CONFIG)
find_package(spdlog CONFIG)
find_package(CLI11 CONFIG)
find_package(nlohmann_json CONFIG)

target_link_libraries(json2cppexe
  PRIVATE
  CLI11::CLI11
  fmt::fmt
  spdlog::spdlog
  nlohmann_json::nlohmann_json)

set_target_properties(json2cppexe PROPERTIES EXPORT_NAME exe)
add_executable(json2cpp::json2cppexe ALIAS json2cppexe)

# installation
install(TARGETS json2cppexe EXPORT json2cppTargets)
