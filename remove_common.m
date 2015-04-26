function remove_common = remove_common(image_start);
% % Get Image from user
% filename = imgetfile;
% image_start = imread(filename);

image_no_background = image_start;
hue_image = rgb2hsv(image_start);
just_hue = hue_image(:,:,1);


%uniquePixels = unique(just_hue);
%n = histc(just_hue, uniquePixels);
%[maxNum, maxInd] = max(n);

%most_freq_hue_value = uniquePixels(maxInd);
most_freq_hue_value = mode(just_hue(:));
THRESHOLD = 0.03;

[height, width, ~] = size(image_start);

for row = 1:height
    for col = 1:width
        hue_value = just_hue(row, col);
        if abs(hue_value - most_freq_hue_value) <= THRESHOLD
            image_no_background(row,col,1) = 0;
            image_no_background(row,col,2) = 0;
            image_no_background(row,col,3) = 0;
        end
    end
end

% imshow(image_no_green);
imwrite(image_no_background, [ 'images\' 'image ' datestr(now, 'dd HH-MM-SS') '.jpg']);
remove_common = image_no_background;