// This file executes the Decision Tree classifier on the given training and test data

#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <iostream>
#include <tuple>
#include "data_labeler.hpp"
#include "trainingAndEvaluation.hpp"

using namespace std;
using namespace cv;
using namespace ml;

int main(void)
{
	cout<<"\n#####THIS PROGRAM TRAINS A DECISION TREE BASED IMAGE CLASSIFIER#####"<<endl;

	Mat training_features, training_labels, test_features, test_labels;
	float score;
	Ptr<DTrees> trained_model;

	// Labeling the training data
	tie(training_features, training_labels) = training_data_labeling();
	cout<<"\nTraining Data Labelled!"<<endl;

	// Training the Decision Tree	
	trained_model = training(training_features, training_labels);
	cout<<"\nModel Trained!"<<endl;

	// Labeling the test data to generate ground truths
	tie(test_features, test_labels) = test_data_features();
	cout<<"\nGround Truths for test data generated!";

	// Evaluating the test data using the trained model and displaying the accuracy score
	score = evaluation(trained_model, test_features, test_labels);
	cout<<"\nAccuracy on Test Set is: "<<score<<" percent"<<endl;
	cout<<"\n#####END PROGRAM#####";

	return 0;
}
	
