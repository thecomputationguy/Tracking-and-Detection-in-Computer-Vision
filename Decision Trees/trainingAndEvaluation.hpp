#ifndef TRAININGANDEVALUATION
#define TRAININGANDEVALUATION

#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <iostream>
#include "opencv2/core/core.hpp"
#include "opencv2/ml/ml.hpp"

using namespace cv;
using namespace std;
using namespace ml;

Ptr<DTrees> training(Mat features, Mat labels);

float evaluation(Ptr<DTrees> model, Mat test_features, Mat test_labels);

#endif


