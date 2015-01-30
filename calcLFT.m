function FIs = calcLFT(Image)

[XX, YY, channels] = size(Image);

assert(channels == 3, 'Requires 3 channels HSV image (%d)', channels);

template = [
    [1,1,1,1,1,1,1,1], % k = 0, (a) 0

    [1,sqrt(2)/2,0,-sqrt(2)/2,-1,-sqrt(2)/2,0,sqrt(2)/2], % k = 1 real, (c) 1

    [1,0,-1,0,1,0,-1,0], % k = 2 real, (e) 2

    [1,-sqrt(2)/2,0,sqrt(2)/2,-1,sqrt(2)/2,0,-sqrt(2)/2], % k = 3 real, (g) 3

    [1,-1,1,-1,1,-1,1,-1], % k = 4, (b) 4

    [0,-sqrt(2)/2,-1,-sqrt(2)/2,0,sqrt(2)/2,1,sqrt(2)/2], % k = 1 imaginary, (d) 5

    [0,-1,0,1,0,-1,0,1], % k = 2 imaginary, (f) 6

    [0,-sqrt(2)/2,1,-sqrt(2)/2,0,sqrt(2)/2,-1,sqrt(2)/2] % k = 3 imaginary, (h) 7
];

for chan = 1 : 3
    % extract the local Fourier coefficients
    Img = Image(:, :, chan);
    
    for k = 0 : 7
        % obtain eight characteristic maps
        for x = 2 : XX-1 % 最外面一圈的处理
            for y = 2 : YY-1
                FIs(chan, x,y,k+1) = 0;
                for n = 0 : 7
                    %    p3 p2 p1
                    %    p4    p0
                    %    p5 p6 p7
                    switch n

                    case {0}
                        FIs(chan, x,y,k+1) = FIs(chan, x,y,k+1) + Img(x+1,y  ) * template(k+1,n+1);
                    case {1}
                        FIs(chan, x,y,k+1) = FIs(chan, x,y,k+1) + Img(x+1,y-1) * template(k+1,n+1);
                    case {2}
                        FIs(chan, x,y,k+1) = FIs(chan, x,y,k+1) + Img(x,  y-1) * template(k+1,n+1);
                    case {3}
                        FIs(chan, x,y,k+1) = FIs(chan, x,y,k+1) + Img(x-1,y-1) * template(k+1,n+1);
                    case {4}
                        FIs(chan, x,y,k+1) = FIs(chan, x,y,k+1) + Img(x-1,y  ) * template(k+1,n+1);
                    case {5}
                        FIs(chan, x,y,k+1) = FIs(chan, x,y,k+1) + Img(x-1,y+1) * template(k+1,n+1);
                    case {6}
                        FIs(chan, x,y,k+1) = FIs(chan, x,y,k+1) + Img(x  ,y+1) * template(k+1,n+1);
                    case {7}
                        FIs(chan, x,y,k+1) = FIs(chan, x,y,k+1) + Img(x+1,y+1) * template(k+1,n+1);
                    
                    end
                end
                FIs(chan, x,y,k+1) = FIs(chan, x,y,k+1) / 8;
            end
        end
    end

end

