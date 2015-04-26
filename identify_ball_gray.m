function identify_ball_gray = identify_ball_gray(image_start, x, y, radius)

image_gray = rgb2gray(image_start);

white_count = 0;
black_count = 0;
for row = (y - radius):(y + radius)
    for col = (x - radius):(x + radius)
        % get value from HSV
        %hsv_px = rgb2hsv(image_start(row, col, :));
        %value = hsv_px(3);
        value = image_gray(row, col);
        
        if value > 190
            white_count = white_count + 1;
        end
        if value < 40
            black_count = black_count + 1;
        end
    end
end

if white_count > 375
    identify_ball_gray = 'cue';
elseif black_count > 350
    identify_ball_gray = 'black';
elseif white_count > 200
    identify_ball_gray = 'striped';
else
    identify_ball_gray = 'solid';
end


