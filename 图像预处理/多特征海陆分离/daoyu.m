I = imread('00bb65eba.jpg');
figure,imshow(I);
I = im2double(rgb2gray(I));%ת��Ϊ�Ҷ�ͼ��
I2=tidu(I);
J= stdfilt(I) ;%����ֲ�����
%figure,imshow(J)%��ʾͼ��
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
%���������޳�
L = bwlabel(~I4,8);%����һ����BW��С��ͬ��L���󣬰����˱����BW��ÿ����ͨ���������ǩ����Щ��ǩ��ֵΪ1��2��num����ͨ����ĸ�����
img_reg = regionprops(L,  'area', 'boundingbox', 'Centroid');%������ͨ����
rects = cat(1,img_reg.BoundingBox);
zhixin = cat(1,img_reg.Centroid);
areas = [img_reg.Area];%�������
[~, max_id] = max(areas);%maxid �����������ı�ǩ
max_rect = (L==max_id);% �ҵ�����ɫ����½�أ�
I5=~I4-max_rect;
%figure,imshow(I5);
I6=~I4-I5;
%figure,imshow(I6);
% se=strel('disk',5);
% I3=imerode(I3,se);
I7=imfill(I6,'holes');
figure,imshow(I7);





