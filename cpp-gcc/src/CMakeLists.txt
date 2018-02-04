project(library)
cmake_minimum_required(VERSION 3.7)

include_directories(../boost ./include)
add_definitions(-std=c++11 -Wall)
add_definitions(-DNOSSL)

set(sources 
   include/StringUtil.h
   include/NameNormalizer.h)
add_library(library ${sources})
target_link_libraries(library pthread)
if(NOT APPLE)
   target_link_libraries(library rt)
endif()
