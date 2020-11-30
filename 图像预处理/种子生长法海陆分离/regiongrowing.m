%�����������������ڻҶ�ͼ���������������
%-------�������-------
%I ��ά�ҶȾ��󣬴�С���⣬����ÿ��Ԫ�صķ�ΧΪ0~1
%x,y ǰ�����ӵ㣨����ԭ�㣩�����꣬ע���䷶Χ������I��
%threshold ��ֵ�������ж������Ƿ�����������������ΧΪ0~1
%-------�������-------
%J double��Mask����0Ϊ������1Ϊǰ��

%modified by Khan in 21090108

function J=regiongrowing(I,x,y,threshold)
if(exist('threshold','var')==0)
    threshold = 0.2;
end
J=zeros(size(I));%���ڱ���������Ķ�ֵ����
[m,n]=size(I);%ͼƬ��С
reg_mean = double(I(x,y));%���ָ������ҶȾ�ֵ
reg_size = 1;%�����е�������Ŀ
%�������ڴ洢�ָ����������Ķ�ս
neg_free = 10000;
neg_pos = 0;
neg_list = zeros(neg_free,3);
delta = 0;%����������������ҶȾ�ֵ�Ĳ�ֵ
%��������ֱ����������
while(delta<threshold && reg_size<numel(I))
    %����������ز��ж��Ƿ��仮������
    for i=-1:1
        for j=-1:1
            %�������������
            xn=x+i;
            yn=y+j;
            %������������Ƿ�Խ��
            indicator = (xn>=1) &&(yn>=1)&&(xn<=m)&&(yn<=n);
            if(indicator && (J(xn,yn)==0))
                %����������ز����ڱ��ָ�����������ջ
                neg_pos = neg_pos+1;
                neg_list(neg_pos,:)=[xn yn I(xn,yn)];
                J(xn,yn)=1;
            end
        end
    end
    %����ջ�ռ䲻�㣬������������
    if(neg_pos+10>neg_free)
        neg_free = neg_free+10000;
        neg_list((neg_pos+1):neg_free,:)=0;
    end
    %����Щ�Ҷ�ֵ��ӽ������ֵ�����ؼ��뵽������
    dist = abs(neg_list(1:neg_pos,3)-reg_mean);
    [delta,index] = min(dist);
    J(x,y)=2;
    reg_size = reg_size+1;
    %�����������ֵ
    reg_mean = (reg_mean*reg_size+neg_list(index,3))/(reg_size+1);
    %�����������꣬Ȼ����Ӷ�ջ���Ƴ�
    x=neg_list(index,1);
    y=neg_list(index,2);
    neg_list(index,:)=neg_list(neg_pos,:);
    neg_pos = neg_pos-1;
end
%������Զ�ֵ������ʽ����
J=J>1;