clear all;
close all;
clc;
 
image1 = imread('00c996565.jpg');

R=im2double(image1(:,:,1));
G=im2double(image1(:,:,2));
B=im2double(image1(:,:,3));
% subplot(1,3,1),imshow(R),title('r');
% subplot(1,3,2),imshow(G),title('g');
% subplot(1,3,3),imshow(B),title('b');
[m, n] = size(image1);
imageR = HomoFilter(R, 3, 0.1, 0.1,max(m,n));                    
imageG = HomoFilter(G, 3, 0.1, 0.1, max(m,n));
imageB = HomoFilter(B, 3, 0.1, 0.1, max(m,n));
RGB=cat(3,imageR,imageG,imageB);%将R、G、B三个矩阵在第3个维度上进行级联，R、G、B顺序不能颠倒
% 显示图像
subplot(1,2,2), imshow(RGB), title('2000');
subplot(1,2,1), imshow(image1), title('原图像');

% thresh = graythresh(win_dark);     %自动确定二值化阈值
% I2 = im2bw(win_dark,thresh);%对图像二值化