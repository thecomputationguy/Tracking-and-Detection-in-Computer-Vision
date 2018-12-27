// This file does the following:
//1. Trains the Decision Tree based on the specified parameters.
//2. Evaluates a test set and returns the number of correctly classifies samples.

#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <iostream>
#include "opencv2/core/core.hpp"
#include "opencv2/ml/ml.hpp"

using namespace std;
using namespace cv;
using namespace ml;

float calculateAccuracy(Mat groundTruths, Mat predictions);

// Training the Decision Tree

Ptr<DTrees> training(Mat features, Mat labels)
{
	Ptr<DTrees> model = DTrees::create();
	model->setMaxDepth(200);
	model->setCVFolds(0);
	model->setMinSampleCount(15);
    	model->train(TrainData::create(features, ROW_SAMPLE, labels));
	model->save("dtrees.yml");

	return model;
}

// Evaluates the test data against the ground-truth

float evaluation(Ptr<DTrees> model, Mat test_features, Mat test_labels)
{
	int counter;
	float accuracy;
	Mat predicted_labels;
	test_features.convertTo(test_features, CV_32F);	
	model->predict(test_features, predicted_labels);
	
	accuracy = calculateAccuracy(test_labels, predicted_labels) * 100;	
		
	return accuracy;
}

// Calculates accuracy based on the ratio of correctly classified samples in the test set.

float calculateAccuracy(Mat groundTruths, Mat predictions)
{
	float counter=0;
	float total_labels = groundTruths.rows;
	float ratio;

	for(int i = 0; i < total_labels; i++)
	{
		//cout<<"Prediction: "<<predictions.at<float>(i,0)<<"; Ground Truth: "<<groundTruths.at<int>(i,0)<<"; Difference: "<<abs((groundTruths.at<int>(i,0) - predictions.at<float>(i,0)));
		if(groundTruths.at<int>(i,0) == predictions.at<float>(i,0))
		{
						
			counter++;
		}
		//cout<<endl;
	}

	cout<<"\n\nTest Data Evaluated!";
	cout<<"\nTest Instances Correctly Classified: "<<counter<<" out of "<<total_labels;

	ratio = (counter/total_labels);

	return ratio;
}
