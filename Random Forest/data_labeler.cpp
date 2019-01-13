// This file does the following:
// 1. Generate labeled data from the training images.
// 2. compute HOG features to be used for training.

#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <iostream>
#include "opencv2/core/core.hpp"
#include <tuple>


using namespace cv;
using namespace std;
using namespace ml;

vector<float> computeHOG(Mat image);

tuple<Mat, Mat> training_data_labeling()
{

	// There are 4 image classes (00-05). So one vector for filenames of each class
	vector<String> filename_class_0;
	vector<String> filename_class_1;
	vector<String> filename_class_2;
	vector<String> filename_class_3;
		
	// Adding the filename of images with a certain name in each class
	glob("./data/train/00/*.jpg", filename_class_0, false);
	glob("./data/train/01/*.jpg", filename_class_1, false);
	glob("./data/train/02/*.jpg", filename_class_2, false);
	glob("./data/train/03/*.jpg", filename_class_3, false);
	
	size_t count_class_0 = filename_class_0.size();
	size_t count_class_1 = filename_class_1.size();
	size_t count_class_2 = filename_class_2.size();
	size_t count_class_3 = filename_class_3.size();
		
	Mat image, image_gray;
	Mat labels; 
	vector<float> feature;
	vector<vector<float>> descriptors;

	int class_no = 0;
	
	// Main loop to generate descriptors with corresponding labels:
	// In the end, 'descriptors' should be a vector of 388 features (total 388 images)
	// and 'labels' should have 388 labels corresponding to descriptors of each image.

	while(class_no <= 3)
	{
		if(class_no == 0)
		{
			for(size_t i = 0; i < count_class_0; i++)
			{
				image = imread(filename_class_0[i]);
				cvtColor(image, image_gray, COLOR_BGR2GRAY);
				resize(image_gray, image_gray, Size(64,64));
				feature = computeHOG(image_gray);
				labels.push_back(class_no);
				descriptors.push_back(feature);
			}
		}

		if(class_no == 1)
		{
			for(size_t i = 0; i < count_class_1; i++)
			{
				image = imread(filename_class_1[i]);
				cvtColor(image, image_gray, COLOR_BGR2GRAY);
				resize(image_gray, image_gray, Size(64,64));
				feature = computeHOG(image_gray);
				labels.push_back(class_no);
				descriptors.push_back(feature);
			}
		}

		if(class_no == 2)
		{
			for(size_t i = 0; i < count_class_2; i++)
			{
				image = imread(filename_class_2[i]);
				cvtColor(image, image_gray, COLOR_BGR2GRAY);
				resize(image_gray, image_gray, Size(64,64));
				feature = computeHOG(image_gray);
				labels.push_back(class_no);
				descriptors.push_back(feature);
			}
		}

		if(class_no == 3)
		{
			for(size_t i = 0; i < count_class_3; i++)
			{
				image = imread(filename_class_3[i]);
				cvtColor(image, image_gray, COLOR_BGR2GRAY);
				resize(image_gray, image_gray, Size(64,64));
				feature = computeHOG(image_gray);
				labels.push_back(class_no);
				descriptors.push_back(feature);
			}
		}

		class_no++;
	}

	// Initializing the containers for the inputs as required by the DTree methods
	Mat training_data(descriptors.at(0).size(), descriptors.size(), CV_32S);
	Mat training_data_label(1, labels.rows, CV_32S);

	// Transferring the descriptors from a vector<vector<float>> to the Mat data type
	for(int i = 0; i < descriptors.size(); i++)
	{
		for(int j = 0; j < descriptors.at(0).size(); j++)
		{
			training_data.at<double>(i,j) = descriptors.at(i).at(j);
		}
	}

	// 'Labels' was initially column-arranged so making it row-arranged
	training_data_label = labels.t();

	training_data = training_data.t();
	training_data_label = training_data_label.t();

	cout<<"\nTotal "<<labels.rows<<" training images processed!";
	cout<<"\nTraining data size: "<<training_data.size();
	cout<<"\nLabel Size: "<<training_data_label.size();

	return make_tuple(training_data, training_data_label);
}

// Function using HOGDescriptor method to generate features
vector<float> computeHOG(Mat image)
{
	vector<Point> locations;
	Size winSize = Size(64,64);
	Size blockSize = Size(4,4);
	Size blockStride = Size(2,2);
	Size cellSize = Size(2,2);
	int  nbins = 9;
	Size winStride = Size(2,2);
	Size padding = Size(0,0);

	vector<float> features;

	HOGDescriptor *hog = new HOGDescriptor(winSize, blockSize, blockStride, cellSize, nbins);

	hog->compute(image, features, winStride, padding, locations);

	return features;
} 	

