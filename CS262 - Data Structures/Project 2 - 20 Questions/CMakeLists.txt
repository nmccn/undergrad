cmake_minimum_required(VERSION 3.13)
project(20_qs)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(20_qs
        animal.cpp animal_functions.cpp animal_functions.h)
