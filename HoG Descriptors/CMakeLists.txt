cmake_minimum_required(VERSION 2.8)
project( HOG_main )
find_package( OpenCV REQUIRED )
include_directories( ${OpenCV_INCLUDE_DIRS} )
add_library(hog_visualization.hpp hog_visualization.cpp)
add_executable( HOG HOG_main.cpp )
target_link_libraries( HOG hog_visualization.hpp ${OpenCV_LIBS} )

