
function [sa] = FT(im)
gfrgb = imfilter(im, fspecial('gaussian', 5, 5), 'symmetric', 'conv');

cform = makecform('srgb2lab');

lab = applycform(gfrgb,cform);

l = double(lab(:,:,1)); lm = mean(mean(l));%����ͼƬ��l��ֵ
a = double(lab(:,:,2)); am = mean(mean(a));

b = double(lab(:,:,3)); bm = mean(mean(b));

sm = (l-lm).^2 + (a-am).^2 + (b-bm).^2;%���ص�������
s=max(sm(:));
sa=sm./s;
end

