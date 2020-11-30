function [k,jz] = hailu(I)
I1 = rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��
%figure,imshow(I);
[h,~]=size(I1);
T=0;
img_thresh = graythresh(I1);
I2 = imbinarize(I1,img_thresh);
%figure,imshow(I2);
% otsu��ֵ��
SE=strel('square',floor(h/20));
I3=imdilate(I2,SE);
%����
%figure,imshow(I3);
[r,c]=find(~I3);%�ҵ��ڵ�
for i=1:length(r)
    if r(i)<=9||r(i)+10>768||c(i)<=9||c(i)+10>768
        continue;
    else
        a=I1(r(i)-9:r(i)+10,c(i)-9:c(i)+10);%�����������
        jz=I(r(i)-9:r(i)+10,c(i)-9:c(i)+10,:);%ѡȡ����1
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
%figure,imshow(k);%k�ǳ������ֵ�ͼ
k=imfill(k,'hole');
k=imfill(~k,'hole');
k=~k;
[L,~] = bwlabel(k,8);
img_reg = regionprops(L,  'area', 'Centroid','boundingbox');%������ͨ����
areas = [img_reg.Area];%�������
[~, max_id] = max(areas);%maxid �����������ı�ǩ
max_rect = I1(L==max_id);
[L1,~] = bwlabel(~k,8);
img_reg1 = regionprops(L1,  'area', 'Centroid','boundingbox');%������ͨ����
areas1 = [img_reg1.Area];%�������
[~, max_id1] = max(areas1);%maxid �����������ı�ǩ
max_rect1 = I1(L1==max_id1);
if std2(max_rect)<std2(max_rect1)&&min(std2(max_rect),std2(max_rect1))<20
    k=~k;
elseif min(std2(max_rect),std2(max_rect1))>30
     k=ones(768);
end
%�Ѿ�����˱�׼�ĺ���½��ͼ�Ҷ����ն��Ѿ����
 [L,~] = bwlabel(~k,8);%����һ����BW��С��ͬ��L���󣬰����˱����BW��ÿ����ͨ���������ǩ����Щ��ǩ��ֵΪ1��2��num����ͨ����ĸ�����
 img_reg = regionprops(L,  'area', 'Centroid','boundingbox');%������ͨ����
%��½�ؾ���
areas = [img_reg.Area];%�������
%rects = cat(1,img_reg.BoundingBox);
[~, max_id] = max(areas);%maxid �����������ı�ǩ
k=(L==max_id);
k=~k;
figure,imshow(k);
end

        






