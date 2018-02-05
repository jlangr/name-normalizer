project(name_normalizer)
cmake_minimum_required(VERSION 3.7)

include_directories(./include)
add_definitions(-std=c++11 -Wall)
add_definitions(-DNOSSL)

set(sources NameNormalizer.cpp include/StringUtil.h)
add_library(name_normalizer ${sources})
target_link_libraries(name_normalizer pthread)
if(NOT APPLE)
   target_link_libraries(name_normalizer rt)
endif()
