function [X,freq]=FT(x,Fs)
N=length(x);
if mod(N,2)==0
    k=-N/2:N/2-1; 
else
    k=-(N-1)/2:(N-1)/2;
end
T=N/Fs;
freq=k/T; %the frequency axis
X=fft(x); % normalize the data
X=fftshift(X); %shifts the fft data so that it is centered
end

