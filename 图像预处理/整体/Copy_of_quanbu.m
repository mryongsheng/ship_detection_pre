clc 
clear 
image_name='1.jpg';
I0=imread(image_name);
R=I0(:,:,1);
G=I0(:,:,2);
B=I0(:,:,3);
[I_hailu,jz]=hailu(I0);%�����ֵͼ
[L,num] = bwlabel(I_hailu,8);
for i=1:num
    if I_hailu(L==i)==1
        R(L==i)=0;
        G(L==i)=0;
        B(L==i)=0;
    end
end
I=cat(3,R,G,B);
I_quwu=dark(I);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
I_panyun=panyun1(I_quwu);%�ٴ������ֵͼ
[L,num] = bwlabel(~I_panyun,8);
for i=1:num
    if I_panyun(L==i)==1
        R(L==i)=0;
        G(L==i)=0;
        B(L==i)=0;
    end
end
I=cat(3,R,G,B);
figure,imshow(I);
T= graythresh(I);
I1=imbinarize(I,T);%��ֵ����I
dst_path='C:\Users\Asus\Documents\MATLAB\����\ͼ��Ԥ����\����\����\';%�ָ�ͼƬ�жϵı���·�� 
%mkdir(dst_path);%·��������������  
[m,n,~] = size(I); %��óߴ� 
for i = 1:4 
    for j = 1:4 
       m_start=1+(i-1)*fix(m/4); 
       m_end=i*fix(m/4); 
       n_start=1+(j-1)*fix(n/4); 
       n_end=j*fix(n/4); 
       A=I(m_start:m_end,n_start:n_end,:); %��ÿ��������
       b=FT(A);
       u=mean2(b);
       fc=std2(b);
       T=u+2*fc;
       c=imbinarize(b,T);
       se=strel('square',7);
       c=imerode(c,se);
       c=imdilate(c,se);
       A1=I1(m_start:m_end,n_start:n_end,:);
       [m1,n1]=size(A);
       a=sum(A1(:));
       d=sum(c(:));
       thresh=a/(m1*n1);
       if thresh>0.2 && d~=0
           imwrite(A,[dst_path num2str(i) '-' num2str(j) '.jpg'],'jpg'); %����ÿ��ͼƬ 
       end
    end 
end
