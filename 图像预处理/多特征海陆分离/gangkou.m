k=imread('1.jpg');
figure,imshow(k);
I= rgb2gray(k);

figure,imshow(I);
[h,w]=size(I);
T = graythresh(I);
B = im2bw(I,T);
figure
figure,imshow(B);

% m=double(rgb2gray(k));
% BW=edge(m,'canny',[0.1,0.2],3);
% 
% se=strel('disk',3);
% I=imdilate(BW,se);
% I2=imfill(I,'holes');
% I3=imerode(I2,se);
% subplot(2,2,2),imshow(I3);
% I4=(B|I3);
% subplot(2,2,3),imshow(I4);
% I4=~I4;
% %bwlabel标记，输出各个位置的大小
% %循环对比大小，取最大的面积标号
% %将它留下a=find（L==1）（length=i）负片回来输出。
% %梯度和灰度整合，适用于港口。
% k1=imclose(I4,se);
% k2=imfill(k1,'holes');
% k3=imopen(k2,se);
% subplot(2,2,4),imshow(k3);
% p=(h*w)/64;
% k4 = bwareaopen(k3,p,8);
% figure,imshow(k4);
