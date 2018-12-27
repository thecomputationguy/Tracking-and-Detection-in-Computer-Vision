%% This Function implements a RANSAC algorithm on a set of input points and selects the best set of points using a distance threshold
%% Inputs:
    %% numSamplePoints : integer, stating how many sample points to consider for the model.
    %% dataPoints : Mx6 array, contains 2d-3d correspondences and their location indexes
    %% threshold : float, specifies the threshold to separate inliers from outliers
    %% iterations : integer, specifies number of iterations to run the algorithm for
    %% worldPoints : Mx5 array, 3D locations of the corresponding points
    %% cameraParameters : cameraParameters object, Camera intrinsic parameters
%% Outputs:
    %% robustPoints : Nx2 array, RANSAC filtered points
    %% bestModel : 4x2 array of points that minimizes the overall re-projection error


function [bestModel,robustPoints] = ransac_rahul(numSamplePoints, dataPoints, threshold, iterations, worldPoints, cameraParameters)
    bestModel = [];
    
    bestError = inf;
    
    robustPoints = [];
    
    % Filtering out duplicate 2D-3D correspondences
    [C, ia] = unique(worldPoints(:,5));
    newWorldPoints = worldPoints(ia, :);
    
    disp("Running RANSAC");
    
    
    for i = 1: iterations
        sampleSize = size(dataPoints, 1); 
        indices = randperm(sampleSize, numSamplePoints); % Randomly select 4 points from the subset
        
        % Initializing the required matrices to store points
        samplePoints1 = zeros(numSamplePoints, 3);
        samplePoints3D = zeros(numSamplePoints, 3);
        samplePoints = zeros(numSamplePoints, 2);
        
        samplePoints1 = dataPoints(indices, 1:3); % 4 points from image 1
        samplePoints2 = dataPoints(indices, 4:6); % 4 points from image 2 
        
        % Find the 3D points corresponding to the 2D points
        samplePoints3D = newWorldPoints(find(ismember(newWorldPoints(:, 5), samplePoints1(:, 3)) == 1), 1:3) 
        samplePoints = samplePoints1(:, 1:2)
       
        
        if (size(samplePoints3D,1) >= 4)
            % Otherwise estimateWorldCameraPose returns an error
            % obtaining initial pose and then8extracting 'R' and 't' matrix/vector
            [initialWorldOrientation, initialWorldLocation] = estimateWorldCameraPose(samplePoints, samplePoints3D, cameraParameters);
            [R, t] = cameraPoseToExtrinsics(initialWorldOrientation, initialWorldLocation); 
            Rt = [R t']
        
            % initializing some necessary variables
            inliers = zeros(sampleSize, 2);
            outliers = zeros(sampleSize, 2);
            numInliers = 0;
            numOutliers = 0;
        
            for j = 1:sampleSize
            
                point3D = samplePoints3D(i,:);
                point2D = samplePoints2(i,:);         
            
                %calculate reprojection
            
                point2DReprojected = cameraParameters * Rt * [point3D; 1];
                point2DReprojected = point2DReprojected(1:2) / point2DReprojected(3);
            
                % Calculate reprojection error
                totalError = 0;
                errorReprojection = norm((point2D - point2DReprojected), 'fro');
                totalError = totalError + errorReprojection;
            
                % perform thresholding            
                if errorReprojection < threshold
                    numInliers = numInliers + 1;
                    inliers(i,:) = point2D;
                else
                    numOutliers = numOutliers + 1;
                    outliers(i,:) = point2D;
                end 
            
            end
        
            % Select best set of points based on the total error of every
            % iteration
            if totalError < bestError
                bestError = totalError;
                robustPoints = inliers; % Best set of inliers
                bestModel = samplePoints2; % Best set of sample points
            end
            
        end 
    end
    
return
