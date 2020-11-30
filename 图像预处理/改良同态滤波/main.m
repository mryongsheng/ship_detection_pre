function RGB=quwu(image1)
R=im2double(image1(:,:,1));
G=im2double(image1(:,:,2));
B=im2double(image1(:,:,3));
[m, n,~] = size(image1);
imageR = HomoFilter(R, 3, 0.1, 0.1,max(m,n));                    
imageG = HomoFilter(G, 3, 0.1, 0.1, max(m,n));
imageB = HomoFilter(B, 3, 0.1, 0.1, max(m,n));
RGB=cat(3,imageR,imageG,imageB);%��R��G��B���������ڵ�3��ά���Ͻ��м�����R��G��B˳���ܵߵ�
% ��ʾͼ��
subplot(2,2,2), imshow(RGB), title('2000');
subplot(2,2,1), imshow(image1), title('ԭͼ��');
hsv1 = rgb2hsv(RGB);
V2 = hsv1(:,:,3); % ���������
hsv2 = rgb2hsv(image1);
V1 = hsv2(:,:,3); % ����ǰ����
%�����滻
for i=1:m
    for j=1:n
        if V2(i,j)<=V1(i,j)
            RGB(i,j,:)=image1(i,j,:);
        end
    end
end
end



