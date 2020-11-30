I=imread('提高照度图像.JPG');
I = rgb2gray(I);%转化为灰度图像
figure,imshow(I);
[h,~]=size(I);
img_thresh = graythresh(I);
I2 = im2bw(I,img_thresh);
figure,imshow(I2);
% otsu二值化
SE=strel('square',floor(h/20));
I3=imdilate(I2,SE);
%膨胀
figure,imshow(I3);
[r,c]=find(~I3);%找到黑点
for i=1:length(r)
    if r(i)<=9||r(i)+10>768||c(i)<=9||c(i)+10>768
        continue;
    else
        a=I(r(i)-9:r(i)+10,c(i)-9:c(i)+10);%考虑溢出问题
        fangcha=std2(a);
        if fangcha<10
            u=mean2(a);
            fch=std2(a);
            T=(u+3*std2(a))/256;
            break;
        end
    end
end
k=im2bw(I,T);
 figure,imshow(k);%k是初步划分的图
% [L,~] = bwlabel(k,8);%返回一个和BW大小相同的L矩阵，包含了标记了BW中每个连通区域的类别标签，这些标签的值为1、2、num（连通区域的个数）
% img_reg = regionprops(L,  'area', 'Centroid','boundingbox');%画出连通区域
% %找陆地矩阵
% areas = [img_reg.Area];%区域面积
% %rects = cat(1,img_reg.BoundingBox);
% [~, max_id] = max(areas);%maxid 就是最大面积的标签
% %max_rect = (L==max_id);
% zhixin = cat(1,img_reg.Centroid);
% x=zhixin(max_id,1);
% y=zhixin(max_id,2);
% lj=I(floor(x)-9:floor(x)+10,floor(y)-9:floor(y)+10);%陆地矩阵
% fcl=std2(lj);
% t= fch+(fcl-fch)/3;
% %误判剔除
% [L,num] = bwlabel(~k,8);
% img_reg = regionprops(L,  'area', 'Centroid','boundingbox');%画出连通区域
% zhixin = cat(1,img_reg.Centroid);
% x=zhixin(:,1);
% y=zhixin(:,2);%x,y为各黑区质心横纵坐标
% %应该向像上面那个那么改，先将就一下
% for i=1:num
%     if x(i)<=9||y(i)<=9||x(i)>=757||y(i)>=757
%         continue;
%     else
%         a=I(ceil(x(i))-9:ceil(x(i))+10,ceil(y(i))-9:ceil(y(i))+10);%考虑溢出问题
%         biaozhuncha=std2(a); 
%         if biaozhuncha>t 
%             k(L==i)=1;%存疑
%         end
%     end
% end
% %这段写得不对,可以用regionprops 的cen
% %figure;imshow(k);
% end

        






