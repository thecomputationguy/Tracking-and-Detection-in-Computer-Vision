cmake_minimum_required(VERSION 2.8)
project( Sobel_Filter )
find_package( OpenCV REQUIRED )
include_directories( ${OpenCV_INCLUDE_DIRS} )
add_executable( EdgeDetector Sobel_Filter.cpp )
target_link_libraries( EdgeDetector ${OpenCV_LIBS} )

