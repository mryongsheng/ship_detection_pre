I=imread('����ն�ͼ��.JPG');
I = rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��
figure,imshow(I);
[h,~]=size(I);
img_thresh = graythresh(I);
I2 = im2bw(I,img_thresh);
figure,imshow(I2);
% otsu��ֵ��
SE=strel('square',floor(h/20));
I3=imdilate(I2,SE);
%����
figure,imshow(I3);
[r,c]=find(~I3);%�ҵ��ڵ�
for i=1:length(r)
    if r(i)<=9||r(i)+10>768||c(i)<=9||c(i)+10>768
        continue;
    else
        a=I(r(i)-9:r(i)+10,c(i)-9:c(i)+10);%�����������
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
 figure,imshow(k);%k�ǳ������ֵ�ͼ
% [L,~] = bwlabel(k,8);%����һ����BW��С��ͬ��L���󣬰����˱����BW��ÿ����ͨ���������ǩ����Щ��ǩ��ֵΪ1��2��num����ͨ����ĸ�����
% img_reg = regionprops(L,  'area', 'Centroid','boundingbox');%������ͨ����
% %��½�ؾ���
% areas = [img_reg.Area];%�������
% %rects = cat(1,img_reg.BoundingBox);
% [~, max_id] = max(areas);%maxid �����������ı�ǩ
% %max_rect = (L==max_id);
% zhixin = cat(1,img_reg.Centroid);
% x=zhixin(max_id,1);
% y=zhixin(max_id,2);
% lj=I(floor(x)-9:floor(x)+10,floor(y)-9:floor(y)+10);%½�ؾ���
% fcl=std2(lj);
% t= fch+(fcl-fch)/3;
% %�����޳�
% [L,num] = bwlabel(~k,8);
% img_reg = regionprops(L,  'area', 'Centroid','boundingbox');%������ͨ����
% zhixin = cat(1,img_reg.Centroid);
% x=zhixin(:,1);
% y=zhixin(:,2);%x,yΪ���������ĺ�������
% %Ӧ�����������Ǹ���ô�ģ��Ƚ���һ��
% for i=1:num
%     if x(i)<=9||y(i)<=9||x(i)>=757||y(i)>=757
%         continue;
%     else
%         a=I(ceil(x(i))-9:ceil(x(i))+10,ceil(y(i))-9:ceil(y(i))+10);%�����������
%         biaozhuncha=std2(a); 
%         if biaozhuncha>t 
%             k(L==i)=1;%����
%         end
%     end
% end
% %���д�ò���,������regionprops ��cen
% %figure;imshow(k);
% end

        






