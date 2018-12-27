#ifndef HOG_VISUALIZATION_H
#define HOG_VISUALIZATION_H

#include <iostream>
#include <stdio.h>
#include <opencv2/opencv.hpp>

void visualizeHOG(cv::Mat img, std::vector<float> &feats, cv::HOGDescriptor hog_detector, int scale_factor);

#endif
