function RGB_map = chart_correction(RGB_reference,RGB_measured)
  %% converting pixel values of images into double
  RGB_reference = im2double(RGB_reference);
  
  RGB_badchart = im2double(RGB_measured);
  
  %% red : estimating the color corrections of red
  rx = RGB_reference(:, 1);
  
  ry = RGB_badchart(:, 1);
  
  [rp, ~, rmu] = polyfit(ry, rx, 1); % using this polyfit method for centering and scaling
  
  rk = linspace(0, 256, 256);
  
  ry_fit = polyval(rp,rk,[],rmu);
  
  %% green : estimating the color corrections of green
  gx = RGB_reference(:, 2);
  
  gy = RGB_badchart(:, 2);
  
  [gp, ~, gmu] = polyfit(gy, gx, 1);  % using this polyfit method for centering and scaling
  
  gk = linspace(0, 256, 256);
  
  gy_fit = polyval(gp,gk,[],gmu);
  
  %% blue : estimating the color corrections of green
  bx = RGB_reference(:, 3);
  
  by = RGB_badchart(:, 3);
  
  [bp, ~, bmu] = polyfit(by, bx, 1); % using this polyfit method for centering and scaling
  
  bk = linspace(0, 256, 256);
  
  by_fit = polyval(bp,bk,[],bmu);
  
  %% 24 x 3 array : color corrections of red, green and blue
  map(:, 1) = ry_fit;
  map(:, 2) = gy_fit;
  map(:, 3) = by_fit;
  
  %% converting the 24x3 array pixel values into uint8
  map = uint8(map);
  
  RGB_map = map;
return