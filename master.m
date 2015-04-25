% Get Image from user
filename = imgetfile;
original_image = imread(filename);
[height, width, depth] = size(original_image);

rectangles = find_position_20(original_image);

radius_min = int32(0.01 * width);
radius_max = int32(0.03 * width);
% [centers, radii] = imfindcircles(original_image, [radius_min, radius_max]);
% [centers, radii] = imfindcircles(original_image, [6, 20], 'Sensitivity', 0.93);
% [centers, radii] = imfindcircles(original_image, [50, 100],'Sensitivity', 0.98);
% circles = [centers int32(radii)];

color = uint8([0 255 0]); % [R G B];
shapeInserter = vision.ShapeInserter('LineWidth', 4,'Shape','Rectangles','BorderColor','Custom','CustomBorderColor',color);%'Custom','CustomBorderColor', uint8([255 0 0]));
boxed_image = step(shapeInserter, original_image, Rectangles); 
% shapeInserter = vision.ShapeInserter('LineWidth', 4,'Shape','Circles','BorderColor','Custom','CustomBorderColor',color);%'Custom','CustomBorderColor', uint8([255 0 0]));
% boxed_image = step(shapeInserter, original_image, circles); 
imshow(boxed_image);