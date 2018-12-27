%{
Calculates the force
R: Rotation as Exponential Map (vector)
T: Translation
A: Intrinsic camera matrix
M: 3D points
m: Corresponding 2D points
%}
function [forceValue] = calc_force(R, T, A, M, m)
    rotM = rotationVectorToMatrix(R);   % Convert from exponential map to rotation matrix
    forceValue = 0;
    cameraParams = cameraParameters('IntrinsicMatrix', A);
    
    for k=1:size(M, 2)
        if(m(:,k)~=0)      
            %Calculate according to ex sheet
            test = worldToImage(cameraParams, rotM, T, M)
            1+1;
            forceValue = forceValue + norm(worldToImage(cameraParams, rotM, T, M) - m(:,k)'); 
        end
    end
    
end

