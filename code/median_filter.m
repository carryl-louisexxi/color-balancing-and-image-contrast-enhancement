function med_img = median_filter(img,M,N)
% ensure img is 0..1 and greyscale
    img = im2double(img);
    if (size(img,3)==3)
      img=rgb2gray(img);
    end

%% getting the image size 
    [hImg, wImg] = size(img);

%% create image with padding
    hpad = 4;
    wpad = 4;

    paddedImg =  zeros(hImg+hpad, wImg+wpad);
    
    for i=1:hImg
        for j=1:wImg
            paddedImg(i + (hpad/2), j+ (wpad/2)) = img(i, j);
        end
    end
%% create filter mask: M by N size
    filtermask = zeros(M, N);

    [hpaddedImg, wpaddedImg] = size(paddedImg);

    med_img = paddedImg;

%% running through the matrix to change the pixel's value (midean)
    for i=1:hpaddedImg -(M-1)
        for j=1:wpaddedImg -(N-1)

            % put the values from the image(padded)to the filter mask
            filtermask(1:M, 1:N)= paddedImg(i:(M-1)+i, j:(N-1)+j);

            % values from the filter mask will be sorted
            sortedval = sort(filtermask(:));

            % mid of sorted value
            mid = ceil((M*N)/2); 

            if rem(M*N, 2) ==  0
                mid = (sortedval(mid) + sortedval(mid+1)/ 2);
            else
                mid = sortedval(mid);
            end

            med_img(ceil(M/2)+(i-1), ceil(N/2)+(j-1)) = mid;

        end
    end
    med_img =  med_img(hpad:end-hpad, wpad:end-wpad);
end
