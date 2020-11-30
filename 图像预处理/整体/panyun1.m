function I2 = panyun1(I)
%img_name='03.jpg';
% 原始图像
I=double(I)/255;
% figure;imshow(I);
%I=imresize(I,[480,640]);
% 获取图像大小

[h,w,c]=size(I);

win_size = 3;

img_size=w*h;

dehaze=zeros(img_size*c,1);

dehaze=reshape(dehaze,h,w,c);
 %subplot(2,2,1),imshow(img_name);
 win_dark=zeros(img_size ,1);

 %darkchannel

for cc=1:img_size

    win_dark(cc)=1;
end

 

win_dark=reshape(win_dark,h,w);

%计算分块darkchannel

 for j=1+win_size:w-win_size

    for i=win_size+1:h-win_size

        m_pos_min = min(I(i,j,:));

        for n=j-win_size:j+win_size

            for m=i-win_size:i+win_size

                if(win_dark(m,n)>m_pos_min)

                    win_dark(m,n)=m_pos_min;

                end

            end

        end

      

   end

 end




 for cc=1:img_size

   win_dark(cc)=1-win_dark(cc);

 end


 %选定精确dark value坐标

win_b = zeros(img_size,1);


%rem函数为求余函数，进行边缘处理

for ci=1:h

    for cj=1:w

        if(rem(ci-8,15)<1)

            if(rem(cj-8,15)<1)

                win_b(ci*w+cj)=win_dark(ci*w+cj);

            end

        end

    end

end
thresh = graythresh(win_dark);     %自动确定二值化阈值
I2 = imbinarize(win_dark,thresh);%对图像二值化
%figure,imshow(I2);
end