function [ImageOut] = HomoFilter(ImageIn, High, Low, C, Sigma)
    Img = double(ImageIn);      %   ת��ͼ�����Ϊ˫������,����ı����ݱ���
    [Height, Width] = size(ImageIn);      % ���ص�����������
    CenterX = floor(Width / 2);     %   ���ĵ�����
    CenterY = floor(Height / 2);
    LogImg = log(Img + 1);      %   ͼ���������
    Log_FFT = fft2(LogImg);     %   ����Ҷ�任
    Log_FFT = fftshift(Log_FFT);
    for Y = 1 : Height 
        for X = 1 : Width 
            Dist= (X - CenterX) * (X - CenterX) + (Y - CenterY) * (Y - CenterY);            %   �㣨X,Y����Ƶ��ƽ��ԭ��ľ���
            H(Y, X)=(High - Low) * (1 - exp(-C * (Dist / (2 * Sigma * Sigma)))) + Low;      %   ̬ͬ�˲�������
        end 
    end                    
    Log_FFT = H.* Log_FFT;              %   �˲���������
    Log_FFT = ifftshift(Log_FFT);
    Log_FFT = ifft2(Log_FFT);           %   ������Ҷ�任 
    
    Out = exp(Log_FFT)-1;               %   ȡָ�� 

    % ָ������ge = exp(g)-1;% ��һ����[0, L-1]
    Max = max(Out(:));
    Min = min(Out(:));
    Range = Max - Min;
    for Y = 1 : Height 
        for X = 1 : Width    
            ImageOut(Y, X) = uint8(255 * (Out(Y, X) - Min) / Range); 
        end
    end
end 