I=rgb2gray(imread('2-4.jpg'));
figure,imshow(I);
[a]=imhist(I);
b=max(a);

