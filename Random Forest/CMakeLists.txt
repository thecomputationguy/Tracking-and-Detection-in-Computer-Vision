project( DecisionTrees )
cmake_minimum_required(VERSION 2.8)
set(CMAKE_CXX_FLAGS "-std=c++0x")
set(CMAKE_BUILD_TYPE RelWithDebInfo)
find_package( OpenCV REQUIRED )

include_directories( ${OpenCV_INCLUDE_DIRS} )

add_library(
	mylibs
	
	data_labeler.hpp data_labeler.cpp 

	newTrainingAndEvaluation.hpp newTrainingAndEvaluation.cpp)

add_executable( rf rf_main.cpp )

target_link_libraries( rf ${OpenCV_LIBS} )

