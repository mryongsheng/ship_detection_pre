function Std=fastLocalstd(Img,d)
[m,n]=size(Img);
Img = padarray(Img,[d+1 d+1],'symmetric');
%�߽����
Img2=Img.^2;
Int=integral(Img);
%����Img�Ļ���ͼ��
Int2=integral(Img2);
%����Img^2�Ļ���ͼ��
Var=zeros(m,n);N=(2*d+1)^2;
%�ֲ����ص����
for i=1:m    
    for j=1:n        
        i1=i+d+1;        
        j1=j+d+1;        
        %���û���ͼ����ֲ���        
        sumi2=Int2(i1+d,j1+d)+Int2(i1-d-1,j1-d-1)-Int2(i1+d,j1-d-1)-Int2(i1-d-1,j1+d);        
        sumi=Int(i1+d,j1+d)+Int(i1-d-1,j1-d-1)-Int(i1+d,j1-d-1)-Int(i1-d-1,j1+d);        
        Var(i,j)=(sumi2-sumi^2/N)/(N-1);    
    end
end
Std=sqrt(Var);
