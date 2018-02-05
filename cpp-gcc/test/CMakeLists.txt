project(name_normalizer_test)
cmake_minimum_required(VERSION 3.7)

include_directories(../googletest/googlemock/include ../googletest/googletest/include ../src/include)
link_directories(../googletest/googlemock ../googletest/googlemock/gtest ../src)
add_definitions(-std=c++11 -Wall)

set(sources 
   main.cpp 
   NameNormalizerTest.cpp
   StringUtilTest.cpp)
add_executable(name_normalizer_test ${sources})
target_link_libraries(name_normalizer_test pthread)
target_link_libraries(name_normalizer_test gmock)
target_link_libraries(name_normalizer_test gtest)
target_link_libraries(name_normalizer_test name_normalizer)

