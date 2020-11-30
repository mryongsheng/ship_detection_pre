clc,clear all;
a=imread('test2.png');
b=FT(a);
figure,imshow(b);
% [L,num]=bwlabel(b,8);
u=mean2(b);
fc=std2(b);
T=u+2*fc;
c=imbinarize(b);
figure,imshow(c);
se=strel('square',5);
c=imerode(c,se);
c=imdilate(c,se);
figure,imshow(c);%至此，如得到全黑图则为纯海去除?
% a=rgb2gray(a);
% b=imbinarize(a);
% figure,imshow(b);
% se=strel('square',5);
% c=imerode(b,se);
% se1=strel('square',15);
% c=imdilate(c,se1);
% figure,imshow(c);
% [L,num]=bwlabel(c,8);
% i=0;
% while i<1
%     [L1,num1]=bwlabel(c,8);
%     img_reg = regionprops(L1,  'area', 'Centroid','boundingbox');
%     Ar = cat(1, img_reg.Area);
%     ind = find(Ar ==max(Ar));%找到最大连通区域的标号
%     c(L1==ind)=0;%将最大面积区域置为0
%     i=i+1;
% end
% 
% 
% figure,imshow(c)
% 
% 
% 
% 
% 

