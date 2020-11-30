function Std=fastLocalstd(Img,d)
[m,n]=size(Img);
Img = padarray(Img,[d+1 d+1],'symmetric');
%边界填充
Img2=Img.^2;
Int=integral(Img);
%计算Img的积分图像
Int2=integral(Img2);
%计算Img^2的积分图像
Var=zeros(m,n);N=(2*d+1)^2;
%局部像素点个数
for i=1:m    
    for j=1:n        
        i1=i+d+1;        
        j1=j+d+1;        
        %利用积分图像求局部和        
        sumi2=Int2(i1+d,j1+d)+Int2(i1-d-1,j1-d-1)-Int2(i1+d,j1-d-1)-Int2(i1-d-1,j1+d);        
        sumi=Int(i1+d,j1+d)+Int(i1-d-1,j1-d-1)-Int(i1+d,j1-d-1)-Int(i1-d-1,j1+d);        
        Var(i,j)=(sumi2-sumi^2/N)/(N-1);    
    end
end
Std=sqrt(Var);
