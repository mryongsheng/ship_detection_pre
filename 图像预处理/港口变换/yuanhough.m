%%MATLAB�������е�Hough�任�������б�Ե���
I=imread('00008.jpg');
I1 = rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��
%figure,imshow(I);
[h,~]=size(I1);
img_thresh = graythresh(I1);
I2 = imbinarize(I1,img_thresh);
figure,imshow(I2);
se=strel('square',7);
k=imdilate(I2,se);
k=imerode(k,se);
k=imfill(k,'holes');
figure,imshow(k);%�����ָ����
BW = bwperim(k);      %������ȡ            
figure,imshow(BW);
%��ͼ�����Hough�任
[H,T,R]=hough(BW);  %[H,theta,rho]
%��ʾ�任��
figure,imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
              'InitialMagnification','fit');
xlabel('\theta');ylabel('\rho');
axis on,axis normal,hold on
title('�任��');
%����任���ֵ
P=houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x=T(P(:,2));y=R(P(:,1));
plot(x,y,'s','color','red');
%���ֱ��
lines=houghlines(BW,T,R,P,'FillGap',50,'MinLength',10);
figure,imshow(I1),hold on
max_len=0;
for k=1:length(lines)
    xy=[lines(k).point1;lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','white');
    %Plot beginning and ends of lines
    plot(xy(1,1),xy(1,2),'xw','LineWidth',2);
    plot(xy(2,1),xy(2,2),'xw','LineWidth',2);
    %Determine the endpoints of the longest line segment
    len=norm(lines(k).point1-lines(k).point2);
    if(len>max_len)
        max_len=len;
        xy_long=xy;
    end
end
title('�����')