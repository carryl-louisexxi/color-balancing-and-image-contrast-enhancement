function B = smart_blur(I,S,tolerance)
%% convert to greyscale 0.0..1.0
    I =im2double(I);
    if (size(I,3)==3)
      I=rgb2gray(I);
    end

%% handle missing input parameters
    if (nargin<2)
      S=5;
      if (nargin<3)
        tolerance = 0.015; % about 4 greylevels for 8bit data
      end
      if (nargin<1)
        error('This function requires an image as input');
      end
    end
    
    img = I;

    [hImg, wImg] = size(img);

%% create padded img
    hpad = 6;
    wpad = 6;

    paddedImg =  zeros(hImg+hpad, wImg+wpad);

    [hpaddedImg, wpaddedImg] = size(paddedImg);

    for i=1:hImg
        for j=1:wImg
            paddedImg(i+(hpad/2), j+(wpad/2)) = img(i, j); %edit
        end
    end

%% matrix with the size of padded img
    cleanImg = zeros(hpaddedImg, wpaddedImg);

%% create filter mask: M by N size
    fmask =  zeros(S, S);
    [M, N] = size(fmask);

%% applying averaging filter
    for i=1:hpaddedImg - (M-1)
        for j=1:wpaddedImg - (N-1)
            % puttign the 3 by 3 mvalues of the padded image to the filter mask
            fmask(1:end, 1:end) = paddedImg(i:(M-1)+i, j:(N-1)+j);

            % sum all the values from the filter mask
            aveval = (sum(fmask, 'all') / (S*S));

            %put the average val to the cleanImg 
            cleanImg(ceil(M/2)+(i-1), ceil(N/2)+(j-1)) = aveval;
        end
    end

%% sobel matrix
    sobelx = [-4 -5 0 5 4; -8 -10 0 10 8; -10 -20 0 20 10; -8 -10 0 10 8; -4 -5 0 5 4];
    sobely = [4 8 10 8 4; 5 10 20 10 5; 0 0 0 0 0; -5 -10 -20 -10 -5; -4 -8 -10 -8 -4];

%% sobelx convolved to image
    Gx = conv2(paddedImg, sobelx(N,N)/240);

%% sobely convolved to image
    Gy = conv2(paddedImg, sobely(N,N)/240);

%% magnitude
    G =  abs(Gx) + abs(Gy);

    w = tolerance ./G;

    B = zeros(size(paddedImg,1), size(paddedImg,2));

    for i=1:hpaddedImg 
        for j=1:wpaddedImg 
            
            % compute the weighting function
            if w(i, j) > 1
                w(i, j) = 1;
            end

            % output image = weighted combination of blurred and original
            B(i, j) =  cleanImg(i, j) + (1-w(i, j)).*(paddedImg(i, j));
            
        end
    end
    B = B(hpad: end-hpad, wpad: end-wpad);
end

