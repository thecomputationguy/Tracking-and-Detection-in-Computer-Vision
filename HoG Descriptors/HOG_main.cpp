#include <iostream>
#include <stdio.h>
#include <opencv2/opencv.hpp>
#include "hog_visualization.hpp"

using namespace cv;
using namespace std;

int main(int argc, char** argv)
{
	char* imageName = argv[1];
	
	// Basic operations - Reading, Resizing and Conversion to Grayscale

	Mat image, resized_image;
	image = imread(imageName, IMREAD_COLOR);
	resize(image, resized_image, Size(128,128));
	Mat gray_image;
	cvtColor(resized_image, gray_image, CV_RGB2GRAY);

	// Defining variables to store the features and their locations

	vector<float> features;
	vector<Point> locations;

	// Defining arguments for the HOG descriptor class

	Size winSize = Size(128,128);
	Size blockSize = Size(16,16);
	Size blockStride = Size(4,4);
	Size cellSize = Size(4,4);
	int  nbins = 9;
	Size winStride = Size(4,4);
	Size padding = Size(0,0);

	// Creating an instance of the HOG Descriptor class using above parameters

	HOGDescriptor *hog = new HOGDescriptor(winSize, blockSize, blockStride, cellSize, 		nbins);
	
	// Computing the feature vectors from the HOG Descriptor methods

	hog->compute(resized_image, features, winStride, padding, locations);
	cout<<"\nSize of feature vector is: "<<features.size()<<endl;

	// Using the provided function to visualize the HOG Features

	int scale_factor = 5;
	visualizeHOG(resized_image, features, *hog, scale_factor);

	waitKey(0);
	return 0;
}

