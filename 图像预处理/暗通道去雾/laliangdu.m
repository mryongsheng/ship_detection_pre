I=imread('1.jpg');
II = im2double(I);
Ir=double(II(:,:,1)); Ig=double(II(:,:,2)); Ib=double(II(:,:,3));
% Global Adaptation
Lw = 0.299 * Ir + 0.587 * Ig + 0.114 * Ib;% input world luminance values
Lwmax = max(max(Lw));% the maximum luminance value
[m, n] = size(Lw);
Lwaver = exp(sum(sum(log(0.001 + Lw))) / (m * n));% log-average luminance
Lg = log(Lw / Lwaver + 1) / log(Lwmax / Lwaver + 1);
gain = Lg ./ Lw;
gain(Lw == 0) = 0;
outval = cat(3, gain .* Ir, gain .* Ig, gain .* Ib);
figure;
imshow(outval)