project(libraryTest)
cmake_minimum_required(VERSION 3.7)

include_directories(../googletest/googlemock/include ../googletest/googletest/include ../src/include)
link_directories(../googletest/googlemock ../googletest/googlemock/gtest ../src)
add_definitions(-std=c++11 -Wall)

set(sources 
   main.cpp 
   NameNormalizerTest.cpp
   StringUtilTest.cpp
   )
add_executable(libraryTest ${sources})
target_link_libraries(libraryTest pthread)
target_link_libraries(libraryTest gmock)
target_link_libraries(libraryTest gtest)
target_link_libraries(libraryTest normalizer)
target_link_libraries(libraryTest ftp++)

