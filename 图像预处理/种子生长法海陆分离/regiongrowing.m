%区域生长函数，用于灰度图像或矩阵的区域生长
%-------输入参数-------
%I 二维灰度矩阵，大小任意，其中每个元素的范围为0~1
%x,y 前景种子点（生长原点）的坐标，注意其范围必须在I内
%threshold 阈值，用于判断邻域是否满足生长条件，范围为0~1
%-------输出参数-------
%J double型Mask矩阵，0为背景，1为前景

%modified by Khan in 21090108

function J=regiongrowing(I,x,y,threshold)
if(exist('threshold','var')==0)
    threshold = 0.2;
end
J=zeros(size(I));%用于标记输出结果的二值矩阵
[m,n]=size(I);%图片大小
reg_mean = double(I(x,y));%被分割的区域灰度均值
reg_size = 1;%区域中的像素数目
%定义用于存储分割区域邻域点的对战
neg_free = 10000;
neg_pos = 0;
neg_list = zeros(neg_free,3);
delta = 0;%新引入像素与区域灰度均值的差值
%区域生长直至满足条件
while(delta<threshold && reg_size<numel(I))
    %检测邻域像素并判断是否将其划入区域
    for i=-1:1
        for j=-1:1
            %计算邻域点坐标
            xn=x+i;
            yn=y+j;
            %检查邻域像素是否越界
            indicator = (xn>=1) &&(yn>=1)&&(xn<=m)&&(yn<=n);
            if(indicator && (J(xn,yn)==0))
                %如果邻域像素不属于被分割区域，则加入堆栈
                neg_pos = neg_pos+1;
                neg_list(neg_pos,:)=[xn yn I(xn,yn)];
                J(xn,yn)=1;
            end
        end
    end
    %若堆栈空间不足，则对其进行扩容
    if(neg_pos+10>neg_free)
        neg_free = neg_free+10000;
        neg_list((neg_pos+1):neg_free,:)=0;
    end
    %将那些灰度值最接近区域均值的像素加入到区域中
    dist = abs(neg_list(1:neg_pos,3)-reg_mean);
    [delta,index] = min(dist);
    J(x,y)=2;
    reg_size = reg_size+1;
    %计算新区域均值
    reg_mean = (reg_mean*reg_size+neg_list(index,3))/(reg_size+1);
    %保存像素坐标，然后将其从堆栈中移除
    x=neg_list(index,1);
    y=neg_list(index,2);
    neg_list(index,:)=neg_list(neg_pos,:);
    neg_pos = neg_pos-1;
end
%将输出以二值矩阵形式给出
J=J>1;