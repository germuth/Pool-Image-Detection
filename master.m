function master
% Get Image from user
filename = imgetfile;
original_image = imread(filename);

% makes image_no_green
image_no_green = first(original_image);
% greyscale
gray_image = rgb2gray(image_no_green);

ball_points = second(gray_image);
rectangles = [];

color = uint8([0 255 0]); % [R G B];
shapeInserter = vision.ShapeInserter('LineWidth', 4,'Shape','Rectangles','BorderColor','Custom','CustomBorderColor',color);%'Custom','CustomBorderColor', uint8([255 0 0]));
for ind=1:length(ball_points)
%     xFinal = ball_x(ind) + BALL_SIZE/2;
%     yFinal = ball_y(ind) + BALL_SIZE/2;
    rectangles = [rectangles; int32([ball_points(2,ind),ball_points(1,ind),20,20])];
end
 
boxed_image = step(shapeInserter, original_image, rectangles); 
imshow(boxed_image);

