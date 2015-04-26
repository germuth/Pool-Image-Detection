% Get Image from user
filename = imgetfile;
original_image = imread(filename);
[height, width, depth] = size(original_image);

radius_min = int32(0.008 * width);
radius_max = int32(0.028 * width);

% Method 1 Part 1 - RGB removal and 20x20 window
% rectangles = find_position_20(original_image);
% shapeInserter = vision.ShapeInserter('LineWidth', 4,'Shape','Rectangles','BorderColor','Custom','CustomBorderColor',color);%'Custom','CustomBorderColor', uint8([255 0 0]));
% boxed_image = step(shapeInserter, original_image, rectangles); 
% imshow(boxed_image)

% Methad 1 Part 2 - Just Hough Circle Transform
% [centers, radii] = imfindcircles(original_image, [radius_min, radius_max]);

% Method 1 Part 3 - HSB removal and HCT
image_removed = remove_common(original_image);
[centers, radii] = imfindcircles(image_removed, [radius_min, radius_max], 'Sensitivity', 0.93);


circles = [centers int32(radii)];
color = uint8([0 255 0]); % [R G B];
shapeInserter = vision.ShapeInserter('LineWidth', 4,'Shape','Circles','BorderColor','Custom','CustomBorderColor',color);

detected_image = original_image;

for ind = 1:length(circles)
    % give circle instead of 3 params
    curr_x = circles(ind,1);
    curr_y = circles(ind,2);
    radius = circles(ind,3);
    
    % Method 2 - Part 1 - Identify ball with HSV value
    classification = identify_ball_HSV(original_image, curr_x, curr_y, radius)
    % Method 2 - Part 2 - Identify ball with gray value
    % classification = identify_ball_gray(original_image, curr_x, curr_y, radius)
    if strcmp(classification, 'striped')
        color = uint8([255 0 0]);
    elseif strcmp(classification, 'solid')
        color = uint8([0 255 0]);
    elseif strcmp(classification, 'cue')
        color = uint8([255 255 255]);
    else
        color = uint8([0 0 0]);
    end
    shapeInserter = vision.ShapeInserter('LineWidth', 4,'Shape','Circles','BorderColor','Custom','CustomBorderColor',color);
    detected_image = step(shapeInserter, detected_image, circles(ind,:)); 
end

imshow(detected_image);