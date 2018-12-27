function [H, bestSet] = ransac(k, S, t, T, N, worldPoints, cameraParams)
sample_count = 0;
sample = zeros(6, k);
errors = zeros(3, size(S, 2));
bestSet = S;
bestValue = 0;

newWorldOrientation = [];
newWorldLocation = [];

% Filter all rows out, that have the same index number in the last column
[C,ia] = unique(worldPoints(:,5));
newSampleWorldPoints = worldPoints(ia,:);



% do N iterations
while sample_count < N 
    
    %select 4 samples
    sample_count = sample_count + 1;
    
    equal = true;
    while equal
        D = randi(size(S, 2),[1, k]);
        if numel(unique(D)) == k
            equal = false;
        end
    end
    
    for i = 1:k
        sample(:,i) = S(:,D(i));
    end
    
    %only valid for image 2
    
    % Try to find the matching entries 2D --> 3D to get the world
    % coordinates of the features
    temp_array = ismember(newSampleWorldPoints(:, 5), sample(3, :));
    temp_array2 = ismember(sample(3, :), newSampleWorldPoints(:, 5));   % Only take index entries that can be found in both point vectors
    sample2 = sample(:, find(temp_array2 == 1));
    newXYZ = newSampleWorldPoints(find(temp_array == 1), 1:3);

    % If at least 4 cooresponding entries are found - meaning a camera positon and pose can be estimated - we try to do so    
    if length(newXYZ) >= 4
        %newWorldPoints = [newXYZ(1:4, :); newXYZ(1:4, :); newXYZ(1:4, :)];
        imagePoints = transpose(sample2(1:2, :));
        imagePoints = [imagePoints; imagePoints];   % otherwise "too few inliers"
        newXYZ = [newXYZ; newXYZ];

        % Estimate the position and orientation of the camera
        [newWorldOrientation, newWorldLocation] = estimateWorldCameraPose(imagePoints, newXYZ, cameraParams)
    end
end
H = newWorldOrientation;
bestSet = newWorldLocation;
return

%{
% Zeig mal was her!
File = read_ply("../data/data/model/teabox.ply");
File(:,3) = -1 * File(:,3);
ptCloud = pointCloud(File);
%Set the color to black for all points in the plot
color = uint8(zeros(ptCloud.Count, 3));
ptCloud.Color = color;

figure;
pcshow(ptCloud, 'MarkerSize', 30, 'VerticalAxis', 'Y');
xlabel('X');
ylabel('Y');
zlabel('Z');
hold on
% Plotting the cameras
plotCamera('Size', 0.025, 'Orientation', newWorldOrientation, 'Location', newWorldLocation)
set(gca, 'CameraPosition', newWorldLocation);
%}
