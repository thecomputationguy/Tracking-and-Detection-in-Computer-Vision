
clear all
%read files
File = read_ply("../data/data/model/teabox.ply");
File(:,3) = -1 * File(:,3);
ptCloud = pointCloud(File);

% Files with corner positions in the images
ptCloud1 = pcread("img1Points.ply");
ptCloud2 = pcread("img2Points.ply");
ptCloud3 = pcread("img3Points.ply");
ptCloud4 = pcread("img4Points.ply");
ptCloud5 = pcread("img5Points.ply");
ptCloud6 = pcread("img6Points.ply");
ptCloud7 = pcread("img7Points.ply");
ptCloud8 = pcread("img8Points.ply");

% The images of the box
img1 = imread('../data/data/images/init_texture/DSC_9743.JPG');
img2 = imread('../data/data/images/init_texture/DSC_9744.JPG');
img3 = imread('../data/data/images/init_texture/DSC_9745.JPG');
img4 = imread('../data/data/images/init_texture/DSC_9746.JPG');
img5 = imread('../data/data/images/init_texture/DSC_9747.JPG');
img6 = imread('../data/data/images/init_texture/DSC_9748.JPG');
img7 = imread('../data/data/images/init_texture/DSC_9749.JPG');
img8 = imread('../data/data/images/init_texture/DSC_9750.JPG');


%read new pictures from ex1task2
imgT1 = imread('../data/data/images/imagesForTask2/DSC_9751.JPG');

%Set the color to black for all points in the plot
color = uint8(zeros(ptCloud.Count, 3));
ptCloud.Color = color;

% Intrinsic camera matrix composed of the given values
IntrinsicMatrix = [2960.37845 0 0; 0 2960.37845 0; 1841.68855 1235.23369 1];
cameraParams = cameraParameters('IntrinsicMatrix', IntrinsicMatrix);

% Positions of the 3D corners for every 2D image
testCorners3Dimg1 = [0 0 0;  0.1650 0 0; 0 0.0930 0; 0.1650 0.0930 0; 0 0.0930 -0.0630; 0.1650 0.0930 -0.0630; 0 0 0;  0.1650 0 0; 0 0.0930 0; 0.1650 0.0930 0; 0 0.0930 -0.0630; 0.1650 0.0930 -0.0630];
testCorners3Dimg2 = [0 0 0;  0.1650 0 0; 0 0.0930 0; 0.1650 0.0930 0; 0.1650 0 -0.0630; 0.1650 0.0930 -0.0630; 0 0.093 -0.065; 0 0 0;  0.1650 0 0; 0 0.0930 0; 0.1650 0.0930 0; 0.1650 0 -0.0630; 0.1650 0.0930 -0.0630; 0 0.093 -0.065];
testCorners3Dimg3 = [0.1650 0 0; 0.1650 0 -0.0630; 0.1650 0.0930 0; 0.1650 0.0930 -0.0630; 0 0.093 0; 0 0.0930 -0.0630; 0.1650 0 0; 0.1650 0 -0.0630; 0.1650 0.0930 0; 0.1650 0.0930 -0.0630; 0 0.093 0; 0 0.0930 -0.0630];
testCorners3Dimg4 = [0.1650 0 0; 0.1650 0 -0.0630; 0.1650 0.0930 0; 0.1650 0.0930 -0.0630; 0 0 -0.063 ; 0 0.0930 -0.0630; 0 0.093 0; 0.1650 0 0; 0.1650 0 -0.0630; 0.1650 0.0930 0; 0.1650 0.0930 -0.0630; 0 0 -0.063 ; 0 0.0930 -0.0630; 0 0.093 0];
testCorners3Dimg5 = [0.1650 0 -0.0630; 0 0 -0.063; 0.1650 0.0930 -0.0630; 0 0.0930 -0.0630; 0.1650 0.093 0; 0 0.0930 0; 0.1650 0 -0.0630; 0 0 -0.063; 0.1650 0.0930 -0.0630; 0 0.0930 -0.0630; 0.1650 0.093 0; 0 0.0930 0];
testCorners3Dimg6 = [0.1650 0 -0.0630; 0 0 -0.063; 0.1650 0.0930 -0.0630; 0 0.0930 -0.0630; 0 0 0; 0 0.093 0; 0.1650 0.0930 0; 0.1650 0 -0.0630; 0 0 -0.063; 0.1650 0.0930 -0.0630; 0 0.0930 -0.0630; 0 0 0; 0 0.093 0; 0.1650 0.0930 0];
testCorners3Dimg7 = [0 0 -0.0630; 0 0 0; 0 0.0930 -0.0630; 0 0.0930 0; 0.1650 0.0930 -0.063; 0.1650 0.093 0; 0 0 -0.0630; 0 0 0; 0 0.0930 -0.0630; 0 0.0930 0; 0.1650 0.0930 -0.063; 0.1650 0.093 0];
testCorners3Dimg8 = [0 0 -0.0630; 0 0 0; 0 0.0930 -0.0630; 0 0.0930 0; 0.1650 0 0; 0.1650 0.093 0; 0.1650 0.093 -0.0630; 0 0 -0.0630; 0 0 0; 0 0.0930 -0.0630; 0 0.0930 0; 0.1650 0 0; 0.1650 0.093 0; 0.1650 0.093 -0.0630];

                                                    %([imagePoints.x imagePoints.y], %worldPoints, cameraParams)
[worldOrientation,worldLocation] = estimateWorldCameraPose([ptCloud1.Location(:, 1) ptCloud1.Location(:, 2)], testCorners3Dimg1, cameraParams);
[worldOrientation2,worldLocation2] = estimateWorldCameraPose([ptCloud2.Location(:, 1) ptCloud2.Location(:, 2)], testCorners3Dimg2, cameraParams);
[worldOrientation3,worldLocation3] = estimateWorldCameraPose([ptCloud3.Location(:, 1) ptCloud3.Location(:, 2)], testCorners3Dimg3, cameraParams);
[worldOrientation4,worldLocation4] = estimateWorldCameraPose([ptCloud4.Location(:, 1) ptCloud4.Location(:, 2)], testCorners3Dimg4, cameraParams);
[worldOrientation5,worldLocation5] = estimateWorldCameraPose([ptCloud5.Location(:, 1) ptCloud5.Location(:, 2)], testCorners3Dimg5, cameraParams);
[worldOrientation6,worldLocation6] = estimateWorldCameraPose([ptCloud6.Location(:, 1) ptCloud6.Location(:, 2)], testCorners3Dimg6, cameraParams);
[worldOrientation7,worldLocation7] = estimateWorldCameraPose([ptCloud7.Location(:, 1) ptCloud7.Location(:, 2)], testCorners3Dimg7, cameraParams);
[worldOrientation8,worldLocation8] = estimateWorldCameraPose([ptCloud8.Location(:, 1) ptCloud8.Location(:, 2)], testCorners3Dimg8, cameraParams);

% Plotting the box
pcshow(ptCloud, 'MarkerSize', 30, 'VerticalAxis', 'Y');
xlabel('X');
ylabel('Y');
zlabel('Z');
hold on
% Plotting the cameras
plotCamera('Size', 0.05, 'Orientation', worldOrientation, 'Location', worldLocation)
plotCamera('Size', 0.05, 'Orientation', worldOrientation2, 'Location', worldLocation2)
plotCamera('Size', 0.05, 'Orientation', worldOrientation3, 'Location', worldLocation3)
plotCamera('Size', 0.05, 'Orientation', worldOrientation4, 'Location', worldLocation4)
plotCamera('Size', 0.05, 'Orientation', worldOrientation5, 'Location', worldLocation5)
plotCamera('Size', 0.05, 'Orientation', worldOrientation6, 'Location', worldLocation6)
plotCamera('Size', 0.05, 'Orientation', worldOrientation7, 'Location', worldLocation7)
plotCamera('Size', 0.05, 'Orientation', worldOrientation8, 'Location', worldLocation8)
hold off

resultValues = [];
figure;

% Initialize descriptor array
descriptorDB = [];
d1 = [];
d2 = [];
d3 = [];
d4 = [];
d5 = [];
d6 = [];
d7 = [];
d8 = [];
f1 = [];
f2 = [];
f3 = [];
f4 = [];
f5 = [];
f6 = [];
f7 = [];
f8 = [];

% For every camera do
for imageRuns = 1:8
    
    % only for initialization
    img = img1;
    worldRotation = worldOrientation;
    worldTranslation = worldLocation;
    

    % Switch camera cases
    switch imageRuns
       case 1
          img = img1;
          worldRotation = worldOrientation;
          worldTranslation = worldLocation;
          
           %extract 2D features using vl_sift of current image
            I = single(rgb2gray(img));  % single precision is sufficient
            [f1,d1] = vl_sift(I) ;    % features, descriptors
            f = f1;
       case 2
          img = img2;
          worldRotation = worldOrientation2;
          worldTranslation = worldLocation2;
          
          %extract 2D features using vl_sift of current image
            I = single(rgb2gray(img));  % single precision is sufficient
            [f2,d2] = vl_sift(I) ;    % features, descriptors
            f = f2;
       case 3
          img = img3;
          worldRotation = worldOrientation3;
          worldTranslation = worldLocation3;
          
          %extract 2D features using vl_sift of current image
            I = single(rgb2gray(img));  % single precision is sufficient
            [f3,d3] = vl_sift(I) ;    % features, descriptors
            f = f3;
       case 4
          img = img4;
          worldRotation = worldOrientation4;
          worldTranslation = worldLocation4;
          
          %extract 2D features using vl_sift of current image
            I = single(rgb2gray(img));  % single precision is sufficient
            [f4,d4] = vl_sift(I) ;    % features, descriptors
            f = f4;
       case 5
          img = img5;
          worldRotation = worldOrientation5;
          worldTranslation = worldLocation5;
          
          %extract 2D features using vl_sift of current image
            I = single(rgb2gray(img));  % single precision is sufficient
            [f5,d5] = vl_sift(I) ;    % features, descriptors
            f = f5;
       case 6
          img = img6;
          worldRotation = worldOrientation6;
          worldTranslation = worldLocation6;
          
          %extract 2D features using vl_sift of current image
            I = single(rgb2gray(img));  % single precision is sufficient
            [f6,d6] = vl_sift(I) ;    % features, descriptors
            f = f6;
       case 7
          img = img7;
          worldRotation = worldOrientation7;
          worldTranslation = worldLocation7;
          
          %extract 2D features using vl_sift of current image
            I = single(rgb2gray(img));  % single precision is sufficient
            [f7,d7] = vl_sift(I) ;    % features, descriptors
            f = f7;
       case 8
          img = img8;
          worldRotation = worldOrientation8;
          worldTranslation = worldLocation8;
          
          %extract 2D features using vl_sift of current image
            I = single(rgb2gray(img));  % single precision is sufficient
            [f8,d8] = vl_sift(I) ;    % features, descriptors
            f = f8;
       otherwise
          
    end

    % Calculate rotation and translation from world to camera space
    [R, T] = cameraPoseToExtrinsics(worldRotation, worldTranslation);
    RT = [R T'];
    %RT = [worldRotation transpose(worldTranslation)];
    P = IntrinsicMatrix' * RT;  % Projection matrix
    Q = P(1:3,1:3);
    invMatrix = inv(Q); % like stated in the exercise
    q = P(1:3, 4);
    C = -invMatrix * q; % C is optical center

    [o, numberF] = size(f); % numbers of features
    m = zeros(numberF, 3);
    allRays = zeros(numberF, 3);

    for k = 1:numberF
        m(k,1) = f(1,k);
        m(k,2) = f(2,k);
        m(k,3) = 1;
    end

    [numberRays, t] = size(m);
    allRays = zeros(numberRays, 3);

    %oneRow = m(1,:)
    for k = 1:numberRays
        % direction of the rays
        allRays(k, :) = invMatrix * transpose(m(k, :));
    end
    
    % just auxiliary variables for the 3D points of the box
    newx0y0z0 = [0 0 0];
    newx1y0z0 = [0.1650 0 0];
    newx0y1z0 = [0 0.0930 0];
    newx1y1z0 = [0.1650 0.0930 0];
    newx1y1z1 = [0.1650 0.0930 -0.630];
    newx1y0z1 = [0.1650 0 -0.630];
    newx0y1z1 = [0 0.0930 -0.630];
    newx0y0z1 = [0 0 -0.630];
 
    
    %Front
    [intersect, distances, u, v, xcoor] = TriangleRayIntersection(C, allRays, newx0y1z0, newx1y0z0, newx0y0z0, 'planeType', 'one sided');
    [intersect2, distances2, u2, v2, xcoor2] = TriangleRayIntersection(C, allRays, newx0y1z0, newx1y1z0, newx1y0z0, 'planeType', 'one sided');
    %normalFront = cross(newx1y0z0-newx0y1z0, newx0y0z0-newx0y1z0);
    %normalFrontCamSpace = RT'*[normalFront, 1]'

    %Back
    [intersect3, distances3, u3, v3, xcoor3] = TriangleRayIntersection(C, allRays, newx0y1z1, newx0y0z1,  newx1y0z1, 'planeType', 'one sided');
    [intersect4, distances4, u4, v4, xcoor4] = TriangleRayIntersection(C, allRays, newx0y1z1, newx1y0z1, newx1y1z1, 'planeType', 'one sided');
    %normalBack = cross(newx0y0z1-newx0y1z1, newx1y0z1-newx0y1z1);
    %normalBackCamSpace = RT'*[normalBack, 1]';

    %Left
    [intersect5, distances5, u5, v5, xcoor5] = TriangleRayIntersection(C, allRays, newx0y1z1, newx0y0z0, newx0y0z1, 'planeType', 'one sided');
    [intersect6, distances6, u6, v6, xcoor6] = TriangleRayIntersection(C, allRays, newx0y1z1, newx0y1z0, newx0y0z0, 'planeType', 'one sided');
    %normalLeft = cross(newx0y0z0-newx0y1z1, newx0y0z1-newx0y1z1);
    %normalLeftCamSpace = RT'*[normalLeft'; 1];

    %Right
    [intersect7, distances7, u7, v7, xcoor7] = TriangleRayIntersection(C, allRays, newx1y1z1, newx1y0z1, newx1y0z0, 'planeType', 'one sided');
    [intersect8, distances8, u8, v8, xcoor8] = TriangleRayIntersection(C, allRays, newx1y1z1, newx1y0z0, newx1y1z0, 'planeType', 'one sided');
    %normalRight = cross(newx1y0z1-newx1y1z1, newx1y0z0-newx1y1z1);
    %normalRightCamSpace = RT'*[normalRight'; 1];

    %Top
    [intersect9, distances9, u9, v9, xcoor9] = TriangleRayIntersection(C, allRays, newx0y1z0,  newx1y1z1, newx1y1z0, 'planeType', 'one sided');
    [intersect10, distances10, u10, v10, xcoor10] = TriangleRayIntersection(C, allRays, newx0y1z1, newx1y1z1, newx0y1z0, 'planeType', 'one sided');
    %normalTop = cross(newx1y1z1-newx0y1z0, newx1y1z0-newx0y1z0);
    %normalTopCamSpace = RT'*[normalTop'; 1];

    %Bottom
    [intersect11, distances11, u11, v11, xcoor11] = TriangleRayIntersection(C, allRays, newx1y0z1, newx0y0z0, newx1y0z0, 'planeType', 'one sided');
    [intersect12, distances12, u12, v12, xcoor12] = TriangleRayIntersection(C, allRays, newx1y0z1, newx0y0z1, newx0y0z0, 'planeType', 'one sided');
    %normalBottom = cross(newx0y0z0-newx1y0z1, newx1y0z0-newx1y0z1);
    %normalBottomCamSpace = RT'*[normalBottom'; 1];

    %for testing if any intersections appear
    result6 = zeros(1,3);
    result2 = zeros(1,3);
    result3 = zeros(1,3);
    result4 = zeros(1,3);
    result5 = zeros(1,3);
    result6 = zeros(1,3);
    result7 = zeros(1,3);
    result8 = zeros(1,3);
    result9 = zeros(1,3);
    result10 = zeros(1,3);
    result11 = zeros(1,3);
    result12 = zeros(1,3);
    
    % Calculate intersection
    
    %if normalFrontCamSpace(3,1) > 0
        result = xcoor(find(intersect == 1), :);
        result(:, 4) = imageRuns;
        result = [result, find(intersect == 1)];
        result2 = xcoor2(find(intersect2 == 1), :);
        result2(:, 4) = imageRuns;
        result2 = [result2, find(intersect2 == 1)];
    %end
    %if normalBackCamSpace(3,1) > 0
        result3 = xcoor3(find(intersect3 == 1), :);
        result3(:, 4) = imageRuns;
        result3 = [result3, find(intersect3 == 1)];
        result4 = xcoor4(find(intersect4 == 1), :);
        result4(:, 4) = imageRuns;
        result4 = [result4, find(intersect4 == 1)];
    %end
    %if normalLeftCamSpace(3,1) > 0
        result5 = xcoor5(find(intersect5 == 1), :);
        result5(:, 4) = imageRuns;
        result5 = [result5, find(intersect5 == 1)];
        result6 = xcoor6(find(intersect6 == 1), :);
        result6(:, 4) = imageRuns;
        result6 = [result6, find(intersect6 == 1)];
    %end
    %if normalRightCamSpace(3,1) > 0
        result7 = xcoor7(find(intersect7 == 1), :);
        result7(:, 4) = imageRuns;
        result7 = [result7, find(intersect7 == 1)];
        result8 = xcoor8(find(intersect8 == 1), :);
        result8(:, 4) = imageRuns;
        result8 = [result8, find(intersect8 == 1)];
    %end
    %if normalTopCamSpace(3,1) > 0
        result9 = xcoor9(find(intersect9 == 1), :);
        result9(:, 4) = imageRuns;
        result9 = [result9, find(intersect9 == 1)];
        result10 = xcoor10(find(intersect10 == 1), :);
        result10(:, 4) = imageRuns;
        result10 = [result10, find(intersect10 == 1)];
    %end
    %if normalBottomCamSpace(3,1) > 0
        result11 = xcoor11(find(intersect11 == 1), :);
        result11(:, 4) = imageRuns;
        result11 = [result11, find(intersect11 == 1)];
        result12 = xcoor12(find(intersect12 == 1), :);
        result12(:, 4) = imageRuns;
        result12 = [result12, find(intersect12 == 1)];
    %end 

    resultTemp = [result; result2; result3; result4; result5; result6; result7; result8; result9; result10; result11; result12];
    resultValues = cat(1, resultValues, resultTemp);
    
end


scatter3(resultValues(:,1), resultValues(:,2), resultValues(:,3));
xlabel('X');
ylabel('Y');
zlabel('Z');

%extract sift keypoints
I = single(rgb2gray(imgT1));  % single precision is sufficient
[f,dNew] = vl_sift(I) ;    % features, descriptors

% Threshold can be set here in the third parameter of vl_ubcmatch
threshold = 2.0;
[matches, scores] = vl_ubcmatch(d2, dNew, threshold);

I = img2;
I2 = imgT1;
ndims = size(I,3);

%place images next to each other
M = zeros(max(size(I,1),size(I2,1)),size(I,2)+size(I2,2),ndims,'like',I);
M(1:size(I,1),1:size(I,2),:) = single(I);
M(1:size(I2,1), size(I,2)+1:size(I,2)+size(I2,2),:) = single(I2);

%draw lines
figure
imshow(M);
title([num2str(size(matches,2)) ' tentative matches'])
hold on;
for i=1:size(matches,2)
    x1 = f2(1,matches(1,i));
    y1 = f2(2,matches(1,i));
    x2 = f(1,matches(2,i))+size(I,2); 
    y2 = f(2,matches(2,i));  
    line([x1,x2],[y1,y2],'Color','g','LineWidth',1)
end
hold off;

S = ones(6, size(matches, 2)); %6 should be enough
for i=1:size(matches, 2)
    S(1, i) = f2(1, matches(1, i)); % xcoordinate of first image in matches
    S(2, i) = f2(2, matches(1, i)); % ycoordinate of first image in matches
    S(3, i) = matches(1, i);
    S(4, i) = f(1, matches(2, i));
    S(5, i) = f(2, matches(2, i));
    S(6, i) = matches(2, i);
end

clc;

k = 8 %num of data points
t = 2 % Threshold set by the user
T = 30 % Number Si
N = 5 % number of iterations set by the user

[newWorldOrientation, newWorldLoc] = ransac(k, S, t, T, N, resultValues, cameraParams);

% An error is thrown here, if the ransac-results are empty!
[R, T] = cameraPoseToExtrinsics(newWorldOrientation, newWorldLoc);
RT = [R T'];
P = IntrinsicMatrix' * RT;  % Projection matrix

x0y0z0 = [0 0 0 1];
x1y0z0 = [0.1650 0 0 1];
x0y1z0 = [0 0.0930 0 1];
x1y1z0 = [0.1650 0.0930 0 1];
x1y1z1 = [0.1650 0.0930 -0.630 1];
x1y0z1 = [0.1650 0 -0.630 1];
x0y1z1 = [0 0.0930 -0.630 1];
x0y0z1 = [0 0 -0.630 1];

new2Dx0y0z0 = P * x0y0z0';
new2Dx0y0z0(1, 1) = new2Dx0y0z0(1, 1) / new2Dx0y0z0(3, 1); 
new2Dx0y0z0(2, 1) = new2Dx0y0z0(2, 1) / new2Dx0y0z0(3, 1);

new2Dx1y0z0 = P * x1y0z0';
new2Dx1y0z0(1, 1) = new2Dx1y0z0(1, 1) / new2Dx1y0z0(3, 1); 
new2Dx1y0z0(2, 1) = new2Dx1y0z0(2, 1) / new2Dx1y0z0(3, 1); 

new2Dx0y1z0 = P * x0y1z0';
new2Dx0y1z0(1, 1) = new2Dx0y1z0(1, 1) / new2Dx0y1z0(3, 1); 
new2Dx0y1z0(2, 1) = new2Dx0y1z0(2, 1) / new2Dx0y1z0(3, 1); 

new2Dx1y1z0 = P * x1y1z0';
new2Dx1y1z0(1, 1) = new2Dx1y1z0(1, 1) / new2Dx1y1z0(3, 1); 
new2Dx1y1z0(2, 1) = new2Dx1y1z0(2, 1) / new2Dx1y1z0(3, 1);

new2Dx1y1z1 = P * x1y1z1';
new2Dx1y1z1(1, 1) = new2Dx1y1z1(1, 1) / new2Dx1y1z1(3, 1); 
new2Dx1y1z1(2, 1) = new2Dx1y1z1(2, 1) / new2Dx1y1z1(3, 1);

new2Dx1y0z1 = P * x1y0z1';
new2Dx1y0z1(1, 1) = new2Dx1y0z1(1, 1) / new2Dx1y0z1(3, 1); 
new2Dx1y0z1(2, 1) = new2Dx1y0z1(2, 1) / new2Dx1y0z1(3, 1);

new2Dx0y1z1 = P * x0y1z1';
new2Dx0y1z1(1, 1) = new2Dx0y1z1(1, 1) / new2Dx0y1z1(3, 1); 
new2Dx0y1z1(2, 1) = new2Dx0y1z1(2, 1) / new2Dx0y1z1(3, 1);

new2Dx0y0z1 = P * x0y0z1';
new2Dx0y0z1(1, 1) = new2Dx0y0z1(1, 1) / new2Dx0y0z1(3, 1); 
new2Dx0y0z1(2, 1) = new2Dx0y0z1(2, 1) / new2Dx0y0z1(3, 1); 

figure;
imshow(imgT1)
%rectangle('Position',[0.5 0.5 10 10], 'EdgeColor', 'g', 'LineWidth', 2);
line([100, 120], [130, 230], 'Color', 'g', 'LineWidth', 2);
line([new2Dx0y0z0(1,  1), new2Dx1y0z0(1,  1)], [new2Dx0y0z0(2,  1), new2Dx1y0z0(2,  1)], 'Color', 'g', 'LineWidth', 2);
line([new2Dx0y0z0(1,  1), new2Dx0y1z0(1, 1)], [new2Dx0y0z0(2,  1), new2Dx0y1z0(2, 1)], 'Color', 'g', 'LineWidth', 2);
line([new2Dx0y0z0(1,  1), new2Dx0y0z1(1, 1)], [new2Dx0y0z0(2,  1), new2Dx0y0z1(2, 1)], 'Color', 'g', 'LineWidth', 2);
line([new2Dx1y1z1(1, 1), new2Dx0y1z1(1, 1)], [new2Dx1y1z1(2, 1), new2Dx0y1z1(2, 1)], 'Color', 'g', 'LineWidth', 2);
line([new2Dx1y1z1(1, 1), new2Dx1y0z1(1, 1)], [new2Dx1y1z1(2, 1), new2Dx1y0z1(2, 1)], 'Color', 'g', 'LineWidth', 2);
line([new2Dx1y1z1(1, 1), new2Dx1y1z0(1, 1)], [new2Dx1y1z1(2, 1), new2Dx1y1z0(2, 1)], 'Color', 'g', 'LineWidth', 2);

line([new2Dx1y1z0(1, 1), new2Dx1y0z0(1, 1)], [new2Dx1y1z0(2, 1), new2Dx1y0z0(2, 1)], 'Color', 'g', 'LineWidth', 2);
line([new2Dx1y1z0(1, 1), new2Dx0y1z0(1, 1)], [new2Dx1y1z0(2, 1), new2Dx0y1z0(2, 1)], 'Color', 'g', 'LineWidth', 2);

line([new2Dx1y0z1(1, 1), new2Dx1y0z0(1, 1)], [new2Dx1y0z1(2, 1), new2Dx1y0z0(2, 1)], 'Color', 'g', 'LineWidth', 2);
line([new2Dx1y0z1(1, 1), new2Dx0y0z1(1, 1)], [new2Dx1y0z1(2, 1), new2Dx0y0z1(2, 1)], 'Color', 'g', 'LineWidth', 2);

line([new2Dx0y1z1(1, 1), new2Dx0y1z0(1, 1)], [new2Dx0y1z1(2, 1), new2Dx0y1z0(2, 1)], 'Color', 'g', 'LineWidth', 2);
line([new2Dx0y1z1(1, 1), new2Dx0y0z1(1, 1)], [new2Dx0y1z1(2, 1), new2Dx0y0z1(2, 1)], 'Color', 'g', 'LineWidth', 2);
