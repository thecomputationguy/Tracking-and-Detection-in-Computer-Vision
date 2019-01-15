// This file does the following:
//1. Trains the Decision Tree based on the specified parameters.
//2. Evaluates a test set and returns the number of correctly classifies samples.

#include <stdio.h>
#include <tuple>
#include <iostream>
#include <random>
#include <algorithm>
#include <iterator>
#include <opencv2/opencv.hpp>
#include "opencv2/core/core.hpp"
#include "opencv2/ml/ml.hpp"
#include "newTrainingAndEvaluation.hpp"

using namespace std;
using namespace cv;
using namespace ml;

float calculateAccuracy(Mat groundTruths, Mat predictions); //Just the implicit declaration

tuple<Mat, Mat> subSampler(Mat features, Mat labels); //Just the implicit declaration


// Creating multiple decision trees to generate a random forest

void RForest::create(int n)
{
    for (int i = 0; i < n; i++)
    {
        Ptr<DTrees> model_instance = DTrees::create();
        model.push_back(model_instance);
    }
}
            
// Training multiple DTrees and evaluating the best one based on accuracy

Ptr<DTrees> RForest::train(Mat features, Mat labels)
{

    Mat subsampledFeatures, subsampledLabels;

    for (int i = 0; i < model.size(); i++)
    {
	tie(subsampledFeatures, subsampledLabels) = subSampler(features, labels); // Training on a random sub-sample
        model[i]->setMaxDepth(200);
        model[i]->setCVFolds(0);
        model[i]->setMinSampleCount(15);
        model[i]->train(TrainData::create(subsampledFeatures, ROW_SAMPLE, subsampledLabels));
        cout<<endl<<"Tree Number: "<< (i + 1) <<" trained!"<<endl;
    }
    
    int index = 0;

    for (int i = 0; i < model.size(); i++)
    {
        cout<<"Evaluating Tree Number: "<<(i + 1)<<endl;
        float accuracy = 0.0, best_accuracy = 0.0;
        
        Mat predicted_labels;
        
        features.convertTo(features, CV_32F);
        
        model[i]->predict(features, predicted_labels);
        
        accuracy = calculateAccuracy(labels, predicted_labels) * 100;

	cout<<"Accuracy is: "<<accuracy<<"%"<<endl;
        
        if(accuracy > best_accuracy)
        {
            best_accuracy = accuracy;
            index = i;
        }
    }
    
    cout<<"Best model is, DTree number: "<<index<<" and is saved."<<endl;
    
    model[index]->save("model.yml");
    
    return model[index];
}

Mat RForest::predict(Mat features) {
    
    //TODO:aggregate predictions from all the trees and vote for the best classification
    //result as well as the confidence (percentage of votes for that winner class)
    Mat result;
    return result;
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
	cout<<"\nTest Instances Correctly Classified: "<<counter<<" out of "<<total_labels<<endl;

	ratio = (counter/total_labels);

	return ratio;
}
 // Function to select a random subset from the complete training data

tuple<Mat, Mat> subSampler(Mat features, Mat labels)
{
	Mat sampledFeatures, sampledLabels, tmpFeature, tmpLabel;
	vector<int> random_indices;
	int index;
	int num_original_samples = features.rows;
	int num_reduced_samples = num_original_samples * 0.6; // Take 60% of the total training data

	for(int i = 0; i < num_original_samples; i++)
	{
		random_indices.push_back(i);
	}

	// Shuffle the full taining data randomly and select the first 60% samples
	random_shuffle(random_indices.begin(), random_indices.end());

	for(int i = 0; i < num_reduced_samples; i++)
	{
		index = random_indices[i];
		tmpFeature = (features.row(index) + 0);
		tmpLabel = (labels.row(index) + 0);
		sampledFeatures.push_back(tmpFeature);
		sampledLabels.push_back(tmpLabel);
	}

	return make_tuple(sampledFeatures, sampledLabels);	
	
}
	






































