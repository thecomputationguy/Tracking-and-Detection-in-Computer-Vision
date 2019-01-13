// This file executes the Decision Tree classifier on the given training and test data

#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <iostream>
#include <tuple>
#include "data_labeler.hpp"
#include "newTrainingAndEvaluation.hpp"

using namespace std;
using namespace cv;
using namespace ml;

int main(void)
{
	cout<<"\n#####THIS PROGRAM TRAINS A DECISION TREE BASED IMAGE CLASSIFIER#####"<<endl;

	Mat training_features, training_labels, test_features, test_labels;
	float score;
        int number_of_decision_trees;
	RForest trained_model;
        
        cout<<"Enter number of trees to include in the forest: ";
        cin>>number_of_decision_trees;

	// Labeling the training data
	tie(training_features, training_labels) = training_data_labeling();
	cout<<"\nTraining Data Labeled!"<<endl;

	// Training the Decision Tree
        trained_model.create(number_of_decision_trees);
	trained_model.train(training_features, training_labels);
	cout<<"\nModel Trained!"<<endl;

	cout<<"\n#####END PROGRAM#####"<<endl<<endl;

	return 0;
}
	
