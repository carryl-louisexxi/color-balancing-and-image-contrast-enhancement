function adjusted_image = apply_rgb_map(RGB_image,RGB_map)
    %% extracting the image color channels.
    R = RGB_image(:,:,1); % Red channel
    G = RGB_image(:,:,2); % Green channel
    B = RGB_image(:,:,3); % Blue channel
    %% getting the size of the color channel
    [hImg,wImg]= size(R);
    
    %% RGB color channel mapping using point operations (RGB_map : look up table)
    for i=1:hImg
        for j=1:wImg
            R(i,j)=RGB_map(R(i,j)+1,1);
            G(i,j)=RGB_map(G(i,j)+1,2);
            B(i,j)=RGB_map(B(i,j)+1,3);
        end
    end
    %% concatenating the corrected r g b using matlab 'cat' function
    adjusted_image = cat(3,R,G,B);
    return
end