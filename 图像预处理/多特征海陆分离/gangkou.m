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
% %bwlabel��ǣ��������λ�õĴ�С
% %ѭ���Աȴ�С��ȡ����������
% %��������a=find��L==1����length=i����Ƭ���������
% %�ݶȺͻҶ����ϣ������ڸۿڡ�
% k1=imclose(I4,se);
% k2=imfill(k1,'holes');
% k3=imopen(k2,se);
% subplot(2,2,4),imshow(k3);
% p=(h*w)/64;
% k4 = bwareaopen(k3,p,8);
% figure,imshow(k4);
