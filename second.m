% OKAY so something isn't making sense
% Im trying to search through the grayscale image
% where all green color has been removed (in a range)
% just try every 20x20 space
% and search for bright areas (225 pixels of vaule 135 or higher)
% but i think the row, col for loop isn't working 
% so take out everything inside and see if it loops through all row and
% column

function second = second(image_sec)
% Get blacked-out image from user
% filename = imgetfile;
% image_start = imread(filename);
[height, width, depth] = size(image_sec);

BALL_SIZE = 20;
THRESHOLD_PIXEL_VALUE = 70;
THRESHOLD_PIXEL_AMOUNT = 300;
THRESHOLD_REGION_CLOSENESS = 20;

ball_x = [];
ball_y = [];
pixel_count = [];
for row = 1:(height - BALL_SIZE)
    for col = 1:(width - BALL_SIZE)
        % [row,col] is top right corner of searching square
        
        pixels = zeros(20);
        i = 1;
        for r = 0:(BALL_SIZE - 1)
            for c = 0:(BALL_SIZE - 1)
                pixels(i) = image_sec(row+r, col+c);
                i = i + 1;
            end
        end
        
        high_pixels = sum(sum(pixels >= THRESHOLD_PIXEL_VALUE));
    
        if high_pixels >= THRESHOLD_PIXEL_AMOUNT
            
            found = 0;
            for ind=1:(length(ball_x))
                x = ball_x(ind);
                y = ball_y(ind);
                if (abs(row - x)) < THRESHOLD_REGION_CLOSENESS
                    if (abs(col - y)) < THRESHOLD_REGION_CLOSENESS
                        found = 1;
                        if pixel_count(ind) < high_pixels
                            ball_x(ind) = row;
                            ball_y(ind) = col;
                            pixel_count(ind) = high_pixels;
                            break;
                        end
                    end
                end
            end
            
            if found == 0
                ball_x = [ball_x row];
                ball_y = [ball_y col];
                pixel_count = [pixel_count high_pixels];
            end
        end
    end
end

% Print out center of each ball location
outputArr = [];
for ind=1:length(ball_x)
%     xFinal = ball_x(ind) + BALL_SIZE/2;
%     yFinal = ball_y(ind) + BALL_SIZE/2;
%     outputArr = [outputArr, [xFinal; yFinal]];
    outputArr = [outputArr, [ball_x(ind); ball_y(ind)]];
end

second = outputArr;
% imshow(image_no_green);
% imwrite(image_no_green, [ 'images\' 'image ' datestr(now, 'dd HH-MM-SS') '.jpg']);

% % Convert to greyscale
% image_start = rgb2gray(image_start);
% imwrite(image_start, ['original_image_greyscale' '.jpg']);
% 
% filters = {'arithmetic', 'geometric', 'harmonic', 'contraharmonic', 'median', 'max', 'min', 'alphatrim'};
% FILTER_SIZE = 9;
% 
% % For Each Filter
% for filter=1:length(filters)
%     ['Currently Applying' filters{filter} ' Filter to Image']
%     
%     image_after = image_start;
%     
%     %For each row in image 
%     for row = 2:511
%         % Create list of 8 surrounding pixels and itself
%         pixels = zeros(1,9);
%         % For each pixel in image (except border)
%         for col = 2:511
%             
%             i = 1;
%             % for each neighbour, 3x3 grid around center pixel
%             for r = (row-1):(row+1)
%                 for c = (col-1):(col+1)
%                     % Avoid zeros because of multiplication in geometric
%                     % filter, only lose very small amount of accuracy
%                     if image_after(r,c) == 0
%                         pixels(i) = 1;
%                     else
%                         pixels(i) = image_after(r, c);
%                     end
%                     i = i + 1;
%                 end
%             end
% 
%             % apply filter
%             switch filters{filter}
%                 case 'arithmetic'
%                     image_after(row,col) = sum(pixels) / FILTER_SIZE;
%                 case 'geometric'
%                     % times them all together
%                     % then exponeent by 1/9
%                     image_after(row,col) = prod(pixels).^(1/FILTER_SIZE);
%                 case 'harmonic'
%                     % sum the inverse of each pixel value
%                     image_after(row,col) = FILTER_SIZE / sum(1./pixels);
%                 case 'contraharmonic'
%                     % sum of squared values divided by normal sum
%                     image_after(row,col) = sum(pixels.^2) / sum(pixels);
%                 case 'median'
%                     image_after(row,col) = median(pixels);
%                 case 'max'
%                     image_after(row,col) = max(pixels);
%                 case 'min'
%                     image_after(row,col) = min(pixels);
%                 case 'alphatrim'
%                     % d == 2, delete min once
%                     [minVal, minIndex] = min(pixels);
%                     pixels(minIndex) = [];
%                     % delete max once
%                     [maxVal, maxIndex] = max(pixels);
%                     pixels(maxIndex) = [];
%                     % calc average
%                     image_after(row,col) = sum(pixels) / (FILTER_SIZE - 2);
%             end
% 
%         end
%     end
%     
%     % Save image
%     imwrite(image_after, [filters{filter} '.jpg']);
% end
% 
% 
% 
