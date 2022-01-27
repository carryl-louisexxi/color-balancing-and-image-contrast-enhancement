%
% A simple TEST for colorchart code
%

truecard = imread('color_testchart.jpg');
RGB_truechart = get_chart_values(truecard);

trueimage = imread('color_toys.jpg');   %<-- you can change this if you like

% -------------------------------------------------------------------------
% test example 1 - reduce all red tones by 50% (cyan colored)
badimage = trueimage;
badimage(:,:,1) = 0.5*badimage(:,:,1);
badtestcard = truecard;
badtestcard(:,:,1) = 0.5*badtestcard(:,:,1);

RGB_badchart = get_chart_values(badtestcard);
RGB_map = chart_correction(RGB_truechart,RGB_badchart);
fixedcard = apply_rgb_map(badtestcard,RGB_map);
fixedimage = apply_rgb_map(badimage,RGB_map);

figure(1)
subplot(2,3,1); image(truecard);title('Reference Card');
subplot(2,3,2); image(badtestcard);title('Bad Card');
subplot(2,3,3); image(fixedcard);title('Fixed Card');
subplot(2,3,4); image(trueimage);title('Reference Image');
subplot(2,3,5); image(badimage);title('Bad Image');
subplot(2,3,6); image(fixedimage);title('Fixed Image');

% -------------------------------------------------------------------------
% test example 2 - reduce min max range and skew colors too (coffee
% colored)
badimage = trueimage;
badimage(:,:,1) = 0.5*badimage(:,:,1);
badimage(:,:,3) = 0.7*badimage(:,:,3);
badimage = 0.5*badimage + 32;
badtestcard = truecard;
badtestcard(:,:,1) = 0.5*badtestcard(:,:,1);
badtestcard(:,:,3) = 0.7*badtestcard(:,:,3);
badtestcard = 0.5*badtestcard + 32;

RGB_badchart = get_chart_values(badtestcard);
RGB_map = chart_correction(RGB_truechart,RGB_badchart);
fixedcard = apply_rgb_map(badtestcard,RGB_map);
fixedimage = apply_rgb_map(badimage,RGB_map);

figure(2)
subplot(2,3,1); image(truecard);title('Reference Card');
subplot(2,3,2); image(badtestcard);title('Bad Card');
subplot(2,3,3); image(fixedcard);title('Fixed Card');

subplot(2,3,4); image(trueimage);title('Reference Image');
subplot(2,3,5); image(badimage);title('Bad Image');
subplot(2,3,6); image(fixedimage);title('Fixed Image');



