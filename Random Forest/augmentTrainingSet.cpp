// This file does the following:
// 1. Generate Augmented training images in training data

#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <iostream>
#include "opencv2/core/core.hpp"
#include <tuple>
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"


using namespace cv;
using namespace std;
using namespace ml;

int MAX_KERNEL_LENGTH = 31;


Mat rotate(Mat src)
{
    double angle = -45;
    
    // get rotation matrix for rotating the image around its center in pixel coordinates
    Point2f center((src.cols-1)/2.0, (src.rows-1)/2.0);
    Mat rot = cv::getRotationMatrix2D(center, angle, 1.0);
    // determine bounding rectangle, center not relevant
    Rect2f bbox = cv::RotatedRect(cv::Point2f(), src.size(), angle).boundingRect2f();
    // adjust transformation matrix
    rot.at<double>(0,2) += bbox.width/2.0 - src.cols/2.0;
    rot.at<double>(1,2) += bbox.height/2.0 - src.rows/2.0;
    Mat dst;
    warpAffine(src, dst, rot, bbox.size());
    return dst;
}

Mat blur(Mat src)
{
    Mat dst = src.clone();
    for ( int i = 1; i < MAX_KERNEL_LENGTH; i = i + 2 )
    {
        GaussianBlur( src, dst, Size( i, i ), 0, 0 );
    }
    return dst;
}

Mat flipImage(Mat src)
{
    Mat dst = src.clone();
    flip(src, dst, 1);
    return dst;
}

void augmentTrainingData()
{
    // There are 4 image classes (00-03). So one vector for filenames of each class
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
    //vector<int> labels;
    vector<vector<float> > descriptors;
    
    int class_no = 0;
    
    while(class_no <= 3)
    {
        if(class_no == 0)
        {
            for(size_t i = 0; i < count_class_0; i++)
            {
                //read file
                image = imread(filename_class_0[i]);
                
                //rotate, blur and flip images
                Mat rotatedImage = rotate(image);
                Mat blurredImage = blur(image);
                Mat flippedImage = flipImage(image);
                
                //save images
                imwrite("./data/train/00/rotated_"+to_string(i)+".jpg", rotatedImage);
                imwrite("./data/train/00/blurred_"+to_string(i)+".jpg", blurredImage);
                imwrite("./data/train/00/flipped_"+to_string(i)+".jpg", flippedImage);
            }
        }
        
        if(class_no == 1)
        {
            for(size_t i = 0; i < count_class_1; i++)
            {
                image = imread(filename_class_1[i]);
                
                //rotate, blur and flip images
                Mat rotatedImage = rotate(image);
                Mat blurredImage = blur(image);
                Mat flippedImage = flipImage(image);
                
                //save images
                imwrite("./data/train/01/rotated_"+to_string(i)+".jpg", rotatedImage);
                imwrite("./data/train/01/blurred_"+to_string(i)+".jpg", blurredImage);
                imwrite("./data/train/01/flipped_"+to_string(i)+".jpg", flippedImage);
            }
        }
        
        if(class_no == 2)
        {
            for(size_t i = 0; i < count_class_2; i++)
            {
                image = imread(filename_class_2[i]);
                
                //rotate, blur and flip images
                Mat rotatedImage = rotate(image);
                Mat blurredImage = blur(image);
                Mat flippedImage = flipImage(image);
                
                //save images
                imwrite("./data/train/02/rotated_"+to_string(i)+".jpg", rotatedImage);
                imwrite("./data/train/02/blurred_"+to_string(i)+".jpg", blurredImage);
                imwrite("./data/train/02/flipped_"+to_string(i)+".jpg", flippedImage);
            }
        }
        
        if(class_no == 3)
        {
            for(size_t i = 0; i < count_class_3; i++)
            {
                image = imread(filename_class_3[i]);
                
                //rotate, blur and flip images
                Mat rotatedImage = rotate(image);
                Mat blurredImage = blur(image);
                Mat flippedImage = flipImage(image);
                
                //save images
                imwrite("./data/train/03/rotated_"+to_string(i)+".jpg", rotatedImage);
                imwrite("./data/train/03/blurred_"+to_string(i)+".jpg", blurredImage);
                imwrite("./data/train/03/flipped_"+to_string(i)+".jpg", flippedImage);
            }
        }
        
        class_no+=1;

	cout<<"Generated Augmented data for training"<<endl;
    }
}


int main()
{
    augmentTrainingData();
}

