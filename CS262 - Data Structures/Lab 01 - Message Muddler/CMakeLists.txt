cmake_minimum_required(VERSION 3.13)
project(lab01)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(lab01
        lab01.cpp
        muddler.cpp
        muddler.h)
