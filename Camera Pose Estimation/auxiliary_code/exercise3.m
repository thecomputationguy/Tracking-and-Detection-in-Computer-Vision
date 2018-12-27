testCorners3Dimg1 = [0 0 0;  0.1650 0 0; 0 0.0930 0; 0.1650 0.0930 0; 0 0.0930 -0.0630; 0 0.0930 -0.0630; 0 0 0;  0.1650 0 0; 0 0.0930 0; 0.1650 0.0930 0; 0 0.0930 -0.0630; 0 0.0930 -0.0630];
ptCloud1 = pcread("imgTestPoints.ply");
File = read_ply("../data/data/model/teabox.ply");
File(:,3) = -1 * File(:,3);
ptCloud = pointCloud(File);
%Set the color to black for all points in the plot
color = uint8(zeros(ptCloud.Count, 3));
ptCloud.Color = color;

%[worldOrientation, worldLocation] = estimateWorldCameraPose([ptCloud1.Location(:, 1) ptCloud1.Location(:, 2)], testCorners3Dimg1, cameraParams);
worldOrientation = [0.863862048367225	-0.00565182779790158	0.503696752256083; -0.00250982198559896	-0.999972934940120	-0.00691593672924054; 0.503722207356777	0.00471022608641281	-0.863852852970823];
worldLocation = [-0.146502059261396	0.0997397009488882	0.418775715126735];

% Intrinsic camera matrix composed of the given values
IntrinsicMatrix = [2960.37845 0 0; 0 2960.37845 0; 1841.68855 1235.23369 1];
cameraParams = cameraParameters('IntrinsicMatrix', IntrinsicMatrix');

figureForCams = figure('Name', 'CameraPlot');
figure(figureForCams);
% Plotting the box
pcshow(ptCloud, 'MarkerSize', 30, 'VerticalAxis', 'Y');
xlabel('X');
ylabel('Y');
zlabel('Z');
hold on

for imageRuns = 1: 47
    
    pictureNumberPrevious = 9775+imageRuns-1;
    pictureNumberCurrent = 9775+imageRuns;
    previousImagePath = strcat('../data/data/images/imagesForTask3/DSC_', num2str(pictureNumberPrevious));
    previousImagePath = strcat(previousImagePath,'.JPG');
    currentImagePath = strcat('../data/data/images/imagesForTask3/DSC_', num2str(pictureNumberCurrent));
    currentImagePath = strcat(currentImagePath,'.JPG');
    imgPrevious = imread(previousImagePath);
    imgCurrent = imread(currentImagePath);
    
    if imageRuns == 1
        % Plotting the cameras in one figure as defined above
        plotImage(imgPrevious, worldOrientation, worldLocation, IntrinsicMatrix);
    end

    I1 = single(rgb2gray(imgPrevious));  % single precision is sufficient
    [f1, d1] = vl_sift(I1) ;    % features, descriptors

    I2 = single(rgb2gray(imgCurrent));  % single precision is sufficient
    [f2, d2] = vl_sift(I2) ;    % features, descriptors

    [matches, scores] = vl_ubcmatch(d1, d2);


    %Ray Intersection calc

    % Calculate rotation and translation from world to camera space
    [R, T] = cameraPoseToExtrinsics(worldOrientation, worldLocation);
    RT = [R T'];
    %RT = [worldRotation transpose(worldTranslation)];
    P = IntrinsicMatrix' * RT;  % Projection matrix
    Q = P(1:3,1:3);
    invMatrix = inv(Q); % like stated in the exercise
    q = P(1:3, 4);
    C = -invMatrix * q; % C is optical center

    [o, numberF] = size(f1); % numbers of features
    m = zeros(numberF, 3);
    allRays = zeros(numberF, 3);

    for k = 1:numberF
        m(k,1) = f1(1,k);
        m(k,2) = f1(2,k);
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
        result = [result, find(intersect == 1)];
        result2 = xcoor2(find(intersect2 == 1), :);
        result2 = [result2, find(intersect2 == 1)];
    %end
    %if normalBackCamSpace(3,1) > 0
        result3 = xcoor3(find(intersect3 == 1), :);
        result3 = [result3, find(intersect3 == 1)];
        result4 = xcoor4(find(intersect4 == 1), :);
        result4 = [result4, find(intersect4 == 1)];
    %end
    %if normalLeftCamSpace(3,1) > 0
        result5 = xcoor5(find(intersect5 == 1), :);
        result5 = [result5, find(intersect5 == 1)];
        result6 = xcoor6(find(intersect6 == 1), :);
        result6 = [result6, find(intersect6 == 1)];
    %end
    %if normalRightCamSpace(3,1) > 0
        result7 = xcoor7(find(intersect7 == 1), :);
        result7 = [result7, find(intersect7 == 1)];
        result8 = xcoor8(find(intersect8 == 1), :);
        result8 = [result8, find(intersect8 == 1)];
    %end
    %if normalTopCamSpace(3,1) > 0
        result9 = xcoor9(find(intersect9 == 1), :);
        result9 = [result9, find(intersect9 == 1)];
        result10 = xcoor10(find(intersect10 == 1), :);
        result10 = [result10, find(intersect10 == 1)];
    %end
    %if normalBottomCamSpace(3,1) > 0
        result11 = xcoor11(find(intersect11 == 1), :);
        result11 = [result11, find(intersect11 == 1)];
        result12 = xcoor12(find(intersect12 == 1), :);
        result12 = [result12, find(intersect12 == 1)];
    %end 
    %combine 3D world points of previous image
    result3DPointsPrevImg = [result; result2; result3; result4; result5; result6; result7; result8; result9; result10; result11; result12];

    %write matches feature 2D points of second(current image) in an own array
    % and safe their pointer to corresponding index in first image for later
    % match with corresponding worldPoints
    imagePoints = ones(3, size(matches, 2)); %6 should be enough
    for i=1:size(matches, 2)
        imagePoints(1, i) = f2(1, matches(2, i)); %xcoordinates of matched features
        imagePoints(2, i) = f2(2, matches(2, i)); %ycoordinates of matched features
        imagePoints(3, i) = matches(1, i);
    end

    %find corresponding worldPoints calculated from image 1 to 2D features of
    %image 2
    worldPoints = zeros(length(imagePoints), 3);
    for i = 1:length(imagePoints)
        index = imagePoints(3, i);
        temp = result3DPointsPrevImg(find(result3DPointsPrevImg(:,4) == index), 1:3);
        if length(temp) > 0
            worldPoints(i, :) = temp(1, 1:3);
        end
    end


    %Energy function to minimize reprojection error
    RexpMap = rotationMatrixToVector(R);
    error = calc_force(RexpMap, T, IntrinsicMatrix', worldPoints, imagePoints(1:2, :))

    %Levenberg-Marquardt Minimization
    
    iterations = 200;
    threshold = 1e-5;
    
    [Rt, error] = lmOptimizer(error, R, T, iterations, threshold);

    R = Rt(1:3, 1:3);
    T = Rt(4, 1:3);
    %now we have improved R and T
    %need to save it globally in worldOrientation and worldLocation
    [worldOrientation, worldLocation] = extrinsicsToCameraPose(R, T);
    
    %GRAPHICS

    figure(figureForCams);
    plotCamera('Size', 0.05, 'Orientation', worldOrientation, 'Location', worldLocation);
    hold on
    % Plotting the cameras in one figure as defined above
    plotImage(imgCurrent, worldOrientation, worldLocation, IntrinsicMatrix);


end

