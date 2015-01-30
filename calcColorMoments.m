function colorMoments = calcColorMoments(FIs)

[channels, XX, YY, KK] = size(FIs);

assert(channels == 3, 'Requires 3 channels Fourier transform (%d)', channels);
assert(KK == 8, 'Requires 8 characteristic maps (%d)', KK);

for chan = 1:3
    % extract color channel
    FI_chan = double(FIs(chan, :, :, :));

    for k = 1:8
        % extract Fourier coefficients
        FI = double(FI_chan(:, :, k));
        % compute 2 first color moments
        moment_mean = mean( FI(:) );
        moment_std  = std( FI(:) );
        % 3x8x2 = 48
        colorMoments(chan, k, :) = [moment_mean moment_std];
    end

end

end

