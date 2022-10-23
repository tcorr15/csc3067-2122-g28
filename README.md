# Pedestrian Detection - Group 28
## About
The modern world is continuously evolving regarding all aspects of technology. 
A plethora of surveillance techniques are currently implemented around the world 
and systems are being improved daily. This program focuses on the processing and 
data collection of video footage to develop a pedestrian detection algorithm. 

Our pedestrian detection system will contain two main sections, the training 
section, and the testing section. The training section will have a goal of 
creating a model that will be able to take an image from the testing set 
(following the same initial procedure of pre-processing and feature extraction) 
and be able to identify if the image contains a pedestrian. Below is a brief 
of the remaining sections:
- Pre-processing: this section will prepare the image. For this we selected 
automatic linear stretching (ALS) and power law (gamma=0.5).
- Feature Extraction: to emphasize key points in the image. For this we selected
histogram of gradients (HoG).
- Classification: a machine learning method to define whether the image contains
a pedestrian or not. For this we selected SVM.
- Detection: creates boxes around a positive pedestrian classification. For this
we selected a multiscale sliding window.

## How to Run
### Full Pipeline with Sliding Window
Select sliding_window.m on MATLAB and run

### SVM pipeline
Select SVM_main.m on MATLAB and run

### K-NN pipeline
Select KNN_main.m on MATLAB and run
