# The MIT License (MIT)
#
# Copyright (c) 2017 Mateusz Pusz Copyright (c) 2022 Martin Wudenka
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
# persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
# Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

cmake_minimum_required(VERSION 3.3)

macro(enable_clang_tidy)
  find_program(clang_tidy_cmd NAMES clang-tidy clang-tidy-15 clang-tidy-14 clang-tidy-13 clang-tidy-12 clang-tidy-11)
  if(NOT clang_tidy_cmd)
    message(FATAL_ERROR "clang-tidy not found!")
  else()
    if(NOT EXISTS "${CMAKE_SOURCE_DIR}/.clang-tidy")
      message(FATAL_ERROR "'${CMAKE_SOURCE_DIR}/.clang-tidy' configuration file not found!")
    endif()
    message(STATUS "Found clang-tidy!")
    set(CMAKE_CXX_CLANG_TIDY
        "${clang_tidy_cmd};--extra-arg-before=--driver-mode=cl;--extra-arg=-Wno-error=unknown-warning-option"
    )
  endif()
endmacro()
