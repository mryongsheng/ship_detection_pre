I=im2double(rgb2gray(imread('00fef1178.jpg')));

figure,imshow(I);
x=100,y=100;
J=regiongrowing(I,x,y,0.2);
figure,imshow(J);
se = strel('disk',4);
k=imerode(~J,se);
figure,imshow(~k);
