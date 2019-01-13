#ifndef DATA_LABELER_H
#define DATA_LABELER_H

#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <iostream>
#include "opencv2/core/core.hpp"
#include <tuple>

using namespace cv;
using namespace std;
using namespace ml;

tuple<Mat, Mat> training_data_labeling();

vector<float> computeHOG(Mat image);

#endif
