
function remove_green = remove_green(image_start);
[height, width, depth] = size(image_start);
image_no_green = image_start;

for row = 1:height
    for col = 1:width
        green = image_start(row, col, 2);
        if ismember(green, 100:150) %green == 126
            image_no_green(row,col,1) = 0;
            image_no_green(row,col,2) = 0;
            image_no_green(row,col,3) = 0;
        end
    end
end

% imshow(image_no_green);
imwrite(image_no_green, [ 'images\' 'image ' datestr(now, 'dd HH-MM-SS') '.jpg']);
remove_green = image_no_green;

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
