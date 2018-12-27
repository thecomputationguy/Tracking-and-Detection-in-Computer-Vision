#include <opencv2/imgproc.hpp>
//#include <opencv2/highui.hpp>
#include <opencv2/opencv.hpp>
#include <iostream>

using namespace cv;
using namespace std;

int main(int argc, char** argv)
{
	cv::CommandLineParser parser(argc, argv,
					"{@input    |lena.png|input image}"
					"{ksize    k|1|ksize (press 'k' to increase value)}"
					"{scale    s|1|ksize (press 's' to increase value)}"
					"{delta    d|0|ksize (press 'd' to increase value)}"
					"{help     h|false|press 'k' to show help}");

	cout<<"This program uses Sobel filters for edge detection\n\n";
	parser.printMessage();
	cout<<"\nPress ESC to exit. \nR to reset values";

	// Declaring Variables

	Mat image, src, src_gray;
	Mat grad;
	const String window_name = "Sobel Demo - Edge Detector";
	int ksize = parser.get<int>("ksize");
	int scale = parser.get<int>("scale");
	int delta = parser.get<int>("delta");
	int ddepth = CV_16S;

	String imageName = parser.get<String>("@input");
	image = imread(imageName, IMREAD_COLOR);

	for(;;)
	{
		//removing noise by gaussian blur
		GaussianBlur(image, src, Size(3,3), 0, 0, BORDER_DEFAULT);

		// Convert to Grayscale
		cvtColor(src, src_gray, COLOR_BGR2GRAY);

		// calculating Gradients
		Mat grad_x, grad_y;
		Mat abs_grad_x, abs_grad_y;

		Sobel(src_gray, grad_x, ddepth, 1, 0, ksize, scale, delta, BORDER_DEFAULT);

		Sobel(src_gray, grad_y, ddepth, 0, 1, ksize, scale, delta, BORDER_DEFAULT);

		// Converting back to CV_8U
		convertScaleAbs(grad_x, abs_grad_x);
		convertScaleAbs(grad_y, abs_grad_y);

		addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0, grad);

		imshow(window_name, grad);
		char key = (char)waitKey(0);

		if(key == 27)
    		{
      			return 0;
    		}
    		if (key == 'k' || key == 'K')
    		{
      			ksize = ksize < 30 ? ksize+2 : -1;
   		}
    		if (key == 's' || key == 'S')
    		{
      			scale++;
		}
    		if (key == 'd' || key == 'D')
    		{
      			delta++;
    		}
    		if (key == 'r' || key == 'R')
    		{
      			scale =  1;
      			ksize = -1;
      			delta =  0;
    		}
	}

	return 0;
}



































