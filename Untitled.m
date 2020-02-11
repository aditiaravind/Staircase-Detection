clc
clear all

% I = zeros(32,32);
% I(:,1:16) = 1;
I = zeros(32,32);
I(:,1:4) = 1;
I(:,8:12) = 1;
I(:,16:20) = 1;
I(:,24:28) = 1;

I(1:4,:) = 1;
I(8:12,:) = 1;
I(16:20,:) = 1;
I(24:28,:) = 1;

h = fspecial('average',3);
A = imfilter(I,h);
subplot(2,2,1)
imshow(I)
subplot(2,2,2)
imshow(A)
subplot(2,2,3)
imhist(I)
subplot(2,2,4)
imhist(A)


