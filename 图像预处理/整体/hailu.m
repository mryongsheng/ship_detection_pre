function [k,jz] = hailu(I)
I1 = rgb2gray(I);%转化为灰度图像
%figure,imshow(I);
[h,~]=size(I1);
T=0;
img_thresh = graythresh(I1);
I2 = imbinarize(I1,img_thresh);
%figure,imshow(I2);
% otsu二值化
SE=strel('square',floor(h/20));
I3=imdilate(I2,SE);
%膨胀
%figure,imshow(I3);
[r,c]=find(~I3);%找到黑点
for i=1:length(r)
    if r(i)<=9||r(i)+10>768||c(i)<=9||c(i)+10>768
        continue;
    else
        a=I1(r(i)-9:r(i)+10,c(i)-9:c(i)+10);%考虑溢出问题
        jz=I(r(i)-9:r(i)+10,c(i)-9:c(i)+10,:);%选取区域1
        fangcha=std2(a);
        if fangcha<10
            u=mean2(a);
            %fch=std2(a);
            T=(u+3*std2(a))/255;
            break;
        end
    end
end
if T>0==false
    T=graythresh(I1);
end
k=imbinarize(I1,T);
%figure,imshow(k);%k是初步划分的图
k=imfill(k,'hole');
k=imfill(~k,'hole');
k=~k;
[L,~] = bwlabel(k,8);
img_reg = regionprops(L,  'area', 'Centroid','boundingbox');%画出连通区域
areas = [img_reg.Area];%区域面积
[~, max_id] = max(areas);%maxid 就是最大面积的标签
max_rect = I1(L==max_id);
[L1,~] = bwlabel(~k,8);
img_reg1 = regionprops(L1,  'area', 'Centroid','boundingbox');%画出连通区域
areas1 = [img_reg1.Area];%区域面积
[~, max_id1] = max(areas1);%maxid 就是最大面积的标签
max_rect1 = I1(L1==max_id1);
if std2(max_rect)<std2(max_rect1)&&min(std2(max_rect),std2(max_rect1))<20
    k=~k;
elseif min(std2(max_rect),std2(max_rect1))>30
     k=ones(768);
end
%已经输出了标准的海黑陆白图且多数空洞已经被填补
 [L,~] = bwlabel(~k,8);%返回一个和BW大小相同的L矩阵，包含了标记了BW中每个连通区域的类别标签，这些标签的值为1、2、num（连通区域的个数）
 img_reg = regionprops(L,  'area', 'Centroid','boundingbox');%画出连通区域
%找陆地矩阵
areas = [img_reg.Area];%区域面积
%rects = cat(1,img_reg.BoundingBox);
[~, max_id] = max(areas);%maxid 就是最大面积的标签
k=(L==max_id);
k=~k;
figure,imshow(k);
end

        






