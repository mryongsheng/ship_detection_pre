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
RGB=cat(3,imageR,imageG,imageB);%��R��G��B���������ڵ�3��ά���Ͻ��м�����R��G��B˳���ܵߵ�
% ��ʾͼ��
subplot(1,2,2), imshow(RGB), title('2000');
subplot(1,2,1), imshow(image1), title('ԭͼ��');

% thresh = graythresh(win_dark);     %�Զ�ȷ����ֵ����ֵ
% I2 = im2bw(win_dark,thresh);%��ͼ���ֵ��