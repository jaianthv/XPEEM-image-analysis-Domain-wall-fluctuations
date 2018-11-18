% Create array to store images in the sequence
Noimage = ; % enter number of images in your image sequence
A=cell(Noimage,1,1);

% Load images and store it in srcFiles, refer matlab for more information on 'srcFiles'
srcFiles = dir('Z:\image*');

for i = 1 : length(srcFiles)

% Clearing the outside part of the image, such as camera frame etc.
    I=imread(srcFiles(i).name);
    imageSize = size(I);
    center = [256, 256, 190];  % center and radius of circle ([c_row, c_col, radius])
    [x,y] = ndgrid((1:imageSize(1))-center(1),(1:imageSize(2))-center(2));
    mask = ((x.^2 + y.^2)<center(3)^2); % in case it does not works use the next line
    %mask = uint8((x.^2 + y.^2)<center(3)^2);
    I=double(I);
    croppedImage=I.*mask;

% Edge detection using 'Canny'. Other edge detection in Matlab is sobel, laplace
    BWs = edge(croppedImage,'canny',0.0105);% adjust the threshold value to obtain a good edge
    imshow(BWs);
    A{[i]}  = BWs; % stores the image in cell "A"

% save image simultaneously while looping, uncomment if not needed
mkdir Processed image;
cd Processed image;
    baseFileName = sprintf('extractedimage_%d.png', i);
    imwrite(A{i,1},baseFileName);

% to save the image with same file name used + processed, uncommment if not needed
    baseFileName = erase(src.Files(i).name,".tif") % erase the extension to get filename
    imwrite(A{i,1},'Processed_image_%s.tif',baseFileName);
cd ..

end

%%% For writing your processed image separately, uncomment if not needed

for i = 1 : length(A)
mkdir Processed image;
cd Processed image;
   baseFileName = sprintf('cropped image %d.png', i);
   imwrite(A{i,1},baseFileName);
cd ..
end
