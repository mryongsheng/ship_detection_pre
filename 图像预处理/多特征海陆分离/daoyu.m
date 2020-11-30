I = imread('00bb65eba.jpg');
figure,imshow(I);
I = im2double(rgb2gray(I));%转化为灰度图像
I2=tidu(I);
J= stdfilt(I) ;%计算局部方差
%figure,imshow(J)%显示图像
k = graythresh(J);
BW = im2bw(J,k);
se=strel('disk',5);
I3=imdilate(BW,se);
I3=imfill(I3,'holes');
I3=imerode(I3,se);
% figure,imshow(I3);
% figure,imshow(BW);
I4=(I3|I2);
%figure,imshow(I4);
%孤立区域剔除
L = bwlabel(~I4,8);%返回一个和BW大小相同的L矩阵，包含了标记了BW中每个连通区域的类别标签，这些标签的值为1、2、num（连通区域的个数）
img_reg = regionprops(L,  'area', 'boundingbox', 'Centroid');%画出连通区域
rects = cat(1,img_reg.BoundingBox);
zhixin = cat(1,img_reg.Centroid);
areas = [img_reg.Area];%区域面积
[~, max_id] = max(areas);%maxid 就是最大面积的标签
max_rect = (L==max_id);% 找到最大白色区域（陆地）
I5=~I4-max_rect;
%figure,imshow(I5);
I6=~I4-I5;
%figure,imshow(I6);
% se=strel('disk',5);
% I3=imerode(I3,se);
I7=imfill(I6,'holes');
figure,imshow(I7);





