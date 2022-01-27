%
% median filter test script
%

I =imread('cameraman.tif'); 
I=imresize(I,0.5);
I=imnoise(I,'salt & pepper',0.02);

M1 = median_filter(I,3,3);
M2 = median_filter(I,6,6);
M3 = median_filter(I,1,10);

figure(66);
colormap(gray);
subplot(2,2,1);
imagesc(I); title('Input Image');
subplot(2,2,2);
imagesc(M1); title('Median [3 3]');
subplot(2,2,3);
imagesc(M2); title('Median [6 6]');
subplot(2,2,4);
imagesc(M3); title('Median [1 10]');

drawnow;


