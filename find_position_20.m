function find_position_20 = find_position_20(original_image)
% makes image_no_green
image_no_green = remove_green(original_image);
% greyscale
gray_image = rgb2gray(image_no_green);

ball_points = second(gray_image);
rectangles = [];

for ind=1:length(ball_points)
%     xFinal = ball_x(ind) + BALL_SIZE/2;
%     yFinal = ball_y(ind) + BALL_SIZE/2;
    rectangles = [rectangles; int32([ball_points(2,ind),ball_points(1,ind),20,20])];
end

find_position_20 = rectangles

