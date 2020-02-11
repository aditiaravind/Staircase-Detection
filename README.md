# Staircase Detection

This is an image processing project to discern the presence/absence of a staircase in an image. 

A dataset of real time pictures were captured which included some basic obstacles like staircase, cartons etc. The images were taken at an interval of 2 seconds to test the efficiency of the detection process.


## Usage
The file "DetectStaircase.m" is the main file to be executed.

However, run the function files: "bfltGray", "bfilter2" and "DistBetween2Segment" first and then the main file.
(Make sure that the pcitures and the files are in the same path)


### Following are the filtering techniques used and a brief description

1. Gray-scale: The RGB images are first converted to gray-scale (black and white) so as to aid better in the object detection. 
2. Sharpening: The gray-scale images were then sharpened so as to make the edges appear more prominently. It was also done to improve the lighting conditions of the images. 
3. Normalization: Normalisation is essentially done before applying the bilateral filter so that the filter works more efficiently. 
4. Bilateral Filter: Bilateral filtering of images with Gaussian kernels. It is used for the smoothening of the image and can be applied several times till the desired output is found. The dimensions of the window used is [3,3] and the value of sigma is [3,3]. Sigma is a parameter of the filter whereas window size decides the parts to be filtered and is based on the Gaussian distribution. 
5. Canny Edge Detection:Edge detection is an image processing technique for finding the boundaries of objects within images.
6. Hough Transform: Hough Transform is used to detect lines,which is represented by the formula - rho = x*cos(theta) + y*sin(theta)
7. Hough Peaks: After the Hough transform is computed, Hough peaks is used to find the peak values in the parameter space which represent the potential lines in the input image.
8. Hough Lines: Hough lines give the endpoint of the line segments, corresponding to the peaks found in the Hough transform.


### Plotting Lines: 
~ The length of the lines is first computed using the coordinates in point 1 and point 2 and the corresponding line is plotted only if its length is greater than 15 pixels. 
~ The longest lines present in the images are highlighted.


## Requirements

This is a completely MATLAB code. You'll need the software to run the code. Alternatively you can access MATLAB online with a MathWorks account.
Soon, this will be implemented in Python as well





