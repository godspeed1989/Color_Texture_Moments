function hsv_image = loadHSVImage(img_file)

% load RGB
rgb_image = imread(img_file);

[XX, YY, channels] = size(rgb_image);
assert(XX>0 && YY>0, 'Image size not valid (%d, %d)', XX, YY);
assert(channels == 3, 'Image channels not valid (%d)', channels);

% convert to HSV
hsv_image = rgb2hsv(rgb_image);

end

