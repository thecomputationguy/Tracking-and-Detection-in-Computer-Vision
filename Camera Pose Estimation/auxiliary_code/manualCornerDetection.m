% This function is responsible for having an easy way to extract the corner
% points from the 2D images

img1 = imread('../data/data/images/init_texture/DSC_9743.JPG');
img2 = imread('../data/data/images/init_texture/DSC_9744.JPG');
img3 = imread('../data/data/images/init_texture/DSC_9745.JPG');
img4 = imread('../data/data/images/init_texture/DSC_9746.JPG');
img5 = imread('../data/data/images/init_texture/DSC_9747.JPG');
img6 = imread('../data/data/images/init_texture/DSC_9748.JPG');
img7 = imread('../data/data/images/init_texture/DSC_9749.JPG');
img8 = imread('../data/data/images/init_texture/DSC_9750.JPG');
imgPrevious = imread('../data/data/images/imagesForTask3/DSC_9775.JPG');



imshow(imgPrevious)
[x] = ginput(6)

y = zeros(6, 3)

for k = 1:6
    y(k,1) = x(k,1)
    y(k,2) = x(k,2)
    y(k,3) = 0
end    
    
%y = [x(1) x(2) 0]

img1XYValues = pointCloud([y; y])
pcwrite(img1XYValues,'imgTestPoints.ply')