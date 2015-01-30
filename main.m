
img_file = 'a.jpg';

hsv_image = loadHSVImage(img_file);

tic

FIs = calcLFT(hsv_image);

colorMoments = calcColorMoments(FIs);

colorMoments = reshape(colorMoments, [1, 3*8*2])

run_time = toc;

fprintf('Testing Time  : %0.2e sec.\n', run_time);

