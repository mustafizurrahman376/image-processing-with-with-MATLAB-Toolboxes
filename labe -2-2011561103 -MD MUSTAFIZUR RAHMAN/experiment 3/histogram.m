clc;
close all;
clear all; 

Imag = imread('onion.png');
figure()
imshow(Imag),title('original image');

ImagGray = rgb2gray(Imag);  % get grayscale image
figure()
imshow(ImagGray),title(' grayscale image ');

[r,c] = size(ImagGray);	% get image size

GrayPixNum = zeros(1,255);
for i = 1:r
for j = 1:c
% Count the number of occurrences of each pixel value
        GrayPixNum(1,ImagGray(i,j)) = GrayPixNum(1,ImagGray(i,j))+1; 
    end
end
% Normalize the grayscale histogram
GrayPixPro = GrayPixNum./(r*c);
figure()
plot(GrayPixPro),title('image histogram');

% Histogram accumulation
GrayAdd = zeros(1,255);  %Get a vector with row 1, column 255, and value 0
GrayAdd(1,1) = GrayPixPro(1,1);
for i = 2:255
    GrayAdd(1,i) = GrayAdd(1,i-1)+GrayPixPro(1,i); %Calculate the pixel cumulative sum
end
NewGray = round(GrayAdd.*254.+0.5);  
NewGrayPro = zeros(1,255);
for i = 1:255
GrayTemp = NewGray(1,i);
%Calculate the pixel values of the new image after equalization
    NewGrayPro(1,GrayTemp) = NewGrayPro(1,GrayTemp)+GrayPixPro(1,i); 
end
figure()
% ‘.*’: Multiply the corresponding element values
plot(NewGrayPro.*(r*c)),title('equalization Histogram');
% Equalized image with equalization histogram and mapping
NewImag = zeros(r,c);  
for i =1:r
    for j = 1:c
        NewImag(i,j) = NewGray(1,ImagGray(i,j));
    end
end
NewImag = uint8(NewImag);
figure()
imshow(NewImag),title('equalized image');  

figure()
plot(NewGray),title('grayscale transformation curve'); 

