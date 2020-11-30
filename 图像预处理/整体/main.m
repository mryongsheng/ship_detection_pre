a=imread('3-3.jpg');
b=FT(a);
figure,imshow(b);
% [L,num]=bwlabel(b,8);
u=mean2(b);
fc=std2(b);
T=u+2*fc;
c=imbinarize(b,T);
figure,imshow(c);
se=strel('square',3);
c=imerode(c,se);
c=imdilate(c,se);
figure,imshow(c);%至此，如得到全黑图则为纯海去除