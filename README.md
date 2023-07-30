# json2cpp

This is a fork of json2cpp that replaces the build system with a [conan 2](https://conan.io/) based one.

**json2cpp** compiles a json file into `static constexpr` C++20 data structures that can be used at compile time or runtime.

# Features

 * Literally 0 runtime overhead for loading the statically compiled JSON resource
 * Fully constexpr capable if you want to make compile-time decisions based on the JSON resource file
 * A `.cpp` firewall file is provided for you, if you have a large resource and don't want to pay the cost of compiling it more than once (but for normal size files it is VERY fast to compile, they are just data structures)
 * [nlohmann::json](https://github.com/nlohmann/json) compatible API (should be a drop-in replacement, some features might still be missing)
 * [valijson](https://github.com/tristanpenman/valijson) adapter file provided

# Usage

See the [test](test) folder for examples for building resources, using the valijson adapter, constexpr usage of resources, and firewalled usage of resources.

Also see the [test_package](test_package) for an example on how to use it with conan 2.

## Development

### Install dependencies

To install its dependencies run

```shell
conan install . -pr:h=default -s:h build_type=Debug -pr:b=default -u --build=missing -c tools.cmake.cmaketoolchain:generator="Ninja Multi-Config" -c tools.cmake.cmake_layout:build_folder_vars="['settings.compiler']" -c user.build:tests=True -c user.build:large_tests=True
```

Now there should be cmake presets ready for you to be used.

## Dependency Installation and Build all in one

```shell
conan build . -pr:h=default -s:h build_type=Debug -pr:b=default -u --build=missing -c tools.cmake.cmaketoolchain:generator="Ninja Multi-Config" -c tools.cmake.cmake_layout:build_folder_vars="['settings.compiler']" -c user.build:tests=True -c user.build:large_tests=True
```

## Packaging

To create a conan package run e.g.
```shell
conan create . --user mwudenka --channel snapshot -pr:h=default -s:h build_type=Release -pr:b=default -u --build=missing

```
