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

float calculateAccuracy(Mat groundTruths, Mat predictions); //Just the implicit declaration

class RForest
{
	public:
            
            vector<Ptr<DTrees>> model;
            
            // Creating multiple decision trees to generate a random forest
            
            void create(int n)
            {
                for int i = 0; i < n; i++
                {
                    Ptr<DTrees> model_instance = DTrees::create();
                    model.push_back(model_instance);
                }						
            }
            
            // Training multiple DTrees and evaluating the best one based on accuracy
            
            Ptr<DTrees> train(Mat features, Mat labels)
            {
                for(int i = 0; i < n; i++)
                {
                    model[i]->setMaxDepth(200);
                    model[i]->setCVFolds(0);
                    model[i]->setMinSampleCount(15);
                    model[i]->train(TrainData::create(features, ROW_SAMPLE, labels));
                    cout<<endl<<"Tree Number: "<<n<<" trained!"<<endl;
                }
                
                for(int i = 0; i < n; i++)
                {
                    int index;
                    float accuracy = 0.0, best_accuracy = 0.0;
                    
                    Mat predicted_labels;
                    
                    test_features.convertTo(test_features, CV_32F);
                    
                    model[i]->predict(features, predicted_labels);
                    
                    accuracy = calculateAccuracy(labels, predicted_labels) * 100;
                    
                    if(accuracy > best_accuracy)
                    {
                        best_accuracy = accuracy;
                        index = i;
                    }
                }
                
                cout<<"Best model is, dtree number: "<<index<<" and is saved."<<endl;
                
                model[index]->save("model.yml")
                        
                return model[index]
            }       
         
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
