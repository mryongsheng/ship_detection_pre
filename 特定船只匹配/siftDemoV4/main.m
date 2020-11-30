
i1=imread('军舰.jpg');
i2=imread('多船图.jpg');
i11=rgb2gray(i1);
i22=rgb2gray(i2);
[h,~]=size(i22);
img_thresh = graythresh(i22);
I2 = imbinarize(i22,img_thresh);
T=img_thresh;
% otsu二值化
SE=strel('square',floor(h/20));
I3=imdilate(I2,SE);
%膨胀
[r,c]=find(~I3);%找到黑点
for i=1:length(r)
    if r(i)<=9||r(i)+10>768||c(i)<=9||c(i)+10>768
        continue;
    else
        a=i22(r(i)-9:r(i)+10,c(i)-9:c(i)+10);%考虑溢出问题
        fangcha=std2(a);
        if fangcha<10
            u=mean2(a);
            fch=std2(a);
            T=(u+3*std2(a))/256;
            break;
        end
    end
end

i4=imbinarize(i22,T);
i4=imfill(i4,'hole');
[L,num] = bwlabel(i4,8);
figure,imshow(i4);%k是初步划分的图
imwrite(i11,'v1.jpg','quality',80);
imwrite(i22,'v2.jpg','quality',80);
he=match('v1.jpg','v2.jpg');%匹配完成输出带点的黑图
x=1:num;
y=zeros(1,num);
for i =1:num
    [r,c]=find(he(L==i));
    if isempty(r)==1
        y(i)=0;
    else
        y(i)=length(r);
    end
end
Fs=1;%采样频率
y1=zeros(1,num);
y1(90)=79;
y1(2)=80;
[YfreqDomain,frequencyRange] = FT(y,Fs);
YfreqDomain = (abs(YfreqDomain)-min(abs(frequencyRange)))/(max(abs(YfreqDomain))-min(abs(YfreqDomain)));
P=[frequencyRange,abs(YfreqDomain)];
% 画出频域图
[YfreqDomain1,frequencyRange1] = FT(y1,Fs);
YfreqDomain1=(abs(YfreqDomain1)-min(abs(frequencyRange1)))/(max(abs(YfreqDomain1))-min(abs(YfreqDomain1)));
Q=[frequencyRange1,abs(YfreqDomain1)];
%画出模板的频域图
% xlabel('Freq (Hz)')
% ylabel('Amplitude')
% title('Using the centeredFFT function')
% grid on;
%至此求完频谱图
a=DiscreteFrechetDist(P,Q);
if a/num<0.1
    disp('目标船只被检测到');
end



