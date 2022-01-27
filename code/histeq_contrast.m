function eq_img = histeq_contrast(GIm)
%% converting the image to uint8 
    GIm = uint8(GIm * 255);
%% getting the size of the image
    [hImg, wImg] = size(GIm);

%% getting the total number of pixel of the image
    numofpixels = hImg * wImg;
    
%% size of the histogran image   
    HIm = uint8(zeros(hImg, wImg));

%% frequency: counts the occurence of each pixel value
    [numFreq, categories] = histcounts(GIm);

%% accumulate the numfreq to graylevels and get the pdf
    freq = zeros(1, 256);
    freqprob = zeros(1, 256);

    fcat = categories(1, 1);
    ecat = categories(1, end);

    count = 1;

    for i=1:255
        if i > fcat && i <= ecat && count < size(categories,2)
            freq(i) = numFreq(1, count);
            freqprob(i) = freq(i)/numofpixels;
            count = count + 1;
        end
    end

%%  get the CDF
    freqcum =  cumsum(freqprob);

%% multiply to highest gray level value
    output = zeros(1, 256);
    for i=1:255
        output(i) = round(freqcum(i)*255);
    end 
%% display
    for i=1:size(GIm,1)
        for j=1:size(GIm,2)
                HIm(i,j)=output(GIm(i,j)+1);
        end
    end
    eq_img = im2double(HIm);
return