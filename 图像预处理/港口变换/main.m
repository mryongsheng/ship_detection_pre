I=imread('00008.jpg');
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
I1 = rgb2gray(I);%转化为灰度图像
%figure,imshow(I);
[h,~]=size(I1);
T=0;
img_thresh = graythresh(I1);
I2 = imbinarize(I1,img_thresh);
figure,imshow(I2);
se=strel('square',7);
k=imdilate(I2,se);
k=imerode(k,se);
k=imfill(k,'holes');
figure,imshow(k);%初步分割结束
%///////////////////////////////////////置零模块
[L,num]=bwlabel(k,8);
for i=1:num
    R(L==i)=0;
    G(L==i)=0;
    B(L==i)=0;
end
I=cat(3,R,G,B);
figure,imshow(I);
I1=rgb2gray(I);
figure,imshow(I1);
contour = bwperim(k);      %轮廓提取            
figure,imshow(contour);


% % EXAMPLE #1:  改进的霍格变换
% fltr4img = [1 2 3 2 1; 2 3 4 3 2; 3 4 6 4 3; 2 3 4 3 2; 1 2 3 2 1];  
% fltr4img = fltr4img / sum(fltr4img(:));  
% imgfltrd = filter2( fltr4img , I1 );  
% [accum, axis_rho, axis_theta, ~, lineseg] = Hough_Grd(imgfltrd, 6, 0.02);  
% DrawLines_2Ends(lineseg);  
% title('Raw Image with Line Segments Detected'); 
%///////////////////////////////////////置零模块
% [L,num]=bwlabel(k,8);
% for i=1:num
%     R(L==i)=0;
%     G(L==i)=0;
%     B(L==i)=0;
% end
% I=cat(3,R,G,B);
% % figure,imshow(I);
%//////////////////////////////////////////显著性检测模块
% b=FT(I);
% figure,imshow(b);
% u=mean2(b);
% fc=std2(b);
% T=u+2*fc;
% c=imbinarize(b,T);
% figure,imshow(c);
% se=strel('square',3);
% c=imerode(c,se);
% c=imdilate(c,se);
% figure,imshow(c);%至此，如得到全黑图则为纯海去除