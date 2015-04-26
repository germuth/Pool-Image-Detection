function identify_ball_HSV = identify_ball_HSV(image_start, x, y, radius)


white_count = 0;
black_count = 0;
for row = (y - radius):(y + radius)
    for col = (x - radius):(x + radius)
        % get value from HSV
        hsv_px = rgb2hsv(image_start(row, col, :));
        value = hsv_px(3);
        
        if value > 0.8
            white_count = white_count + 1;
        end
        if value < 0.2
            black_count = black_count + 1;
        end
    end
end

if white_count > 375
    identify_ball_HSV = 'cue';
elseif black_count > 350
    identify_ball_HSV = 'black';
elseif white_count > 200
    identify_ball_HSV = 'striped';
else
    identify_ball_HSV = 'solid';
end


