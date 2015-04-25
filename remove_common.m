function remove_common = remove_common(image_start);
% % Get Image from user
% filename = imgetfile;
% image_start = imread(filename);

uniquePixels = unique(image_start);
n = histc(image_start(:,:,2), uniquePixels);
[maxNum, maxInd] = max(n);
most_freq_px = uniquePixels(maxInd);

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
remove_common = image_no_green;