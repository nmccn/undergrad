cmake_minimum_required(VERSION 3.12)
project(sfml_template)

include_directories(include)
link_directories(lib)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY bin)

add_executable(sfml_template main.cpp)

target_link_libraries(sfml_template sfml-audio sfml-graphics sfml-system sfml-window sfml-network)

add_custom_command(TARGET sfml_template
        POST_BUILD COMMAND
        ${CMAKE_INSTALL_NAME_TOOL} -add_rpath "@executable_path/../../Frameworks/"
        $<TARGET_FILE:sfml_template>)

