function [result] = plotImage(image, worldOrientation, worldLocation, IntrinsicMatrix)

    % An error is thrown here, if the ransac-results are empty!
    [R, T] = cameraPoseToExtrinsics(worldOrientation, worldLocation);
    RT = [R T'];
    P = IntrinsicMatrix' * RT;  % Projection matrix

    x0y0z0 = [0 0 0 1];
    x1y0z0 = [0.1650 0 0 1];
    x0y1z0 = [0 0.0930 0 1];
    x1y1z0 = [0.1650 0.0930 0 1];
    x1y1z1 = [0.1650 0.0930 0.1*-0.630 1];
    x1y0z1 = [0.1650 0 0.1*-0.630 1];
    x0y1z1 = [0 0.0930 0.1*-0.630 1];
    x0y0z1 = [0 0 0.1*-0.630 1];

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
    imshow(image);

    %rectangle('Position',[0.5 0.5 10 10], 'EdgeColor', 'g', 'LineWidth', 2);
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
    
    
    result = true;
end

