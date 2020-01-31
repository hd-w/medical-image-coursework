%实验2.5：分别用逆滤波和维纳滤波恢复图像 inverse filter & Wiener filter
%读图
clear all;
fid = fopen('smooth.img','rb'); 
    C=fread(fid,65536,'float32');
fclose(fid);
for i=1:256
    for j=1:256
        A(i,j)=C((i-1)*256+j);  
    end
end
A=A';
figure;
maxmax=max(max(A));
minmin=min(min(A));
imshow(A,[minmin,maxmax]);title('原图像');
B=zeros(512,512);
for i=1:256
    for j=1:256
        B(i,j)=A(i,j);
    end
end

F=fftshift(fft2(B));%原图像做二维傅里叶变换

k1=0.0025;%逆滤波中的k值
k2=0.001;%维纳滤波中的k值
d0=60;%低通滤波截止频率

[m,n]=size(B);
for u=1:m
    for v=1:n
       H(u,v)=exp(-k1*((u-m/2)^2+(v-n/2)^2)^(5/6));%点扩展函数
       H2(u,v)=abs(H(u,v))^2;%绝对值的平方,维纳滤波函数中的一部分
    end
end
%图像恢复
n0=10;
G=F./H;
for i=1:m
    for j=1:n
        d(i,j)=sqrt((i-m/2)^2+(j-n/2)^2);
        h(i,j)=1/(1+(d(i,j)/d0)^(2*n0));
    end
end
F1=h.*G;
f1=real(ifft2(ifftshift(F1)));
for i=1:256
    for j=1:256
           c1(i,j)=f1(i,j);  
    end
end
figure;
maxmax1=max(max(c1));
minmin1=min(min(c1));
imshow(c1,[minmin1,maxmax1]);
title('逆滤波恢复后的图像');


HW=(1./H).*(H2./(H2+k2));   %维纳滤波系统函数
F2=HW.*F;    %维纳滤波后的傅里叶变换
f2=real(ifft2(ifftshift(F2)));  %维纳滤波图像恢复
for i=1:256
    for j=1:256
           c2(i,j)=f2(i,j);  
    end
end
figure;
maxmax2=max(max(c2));
minmin2=min(min(c2));
imshow(c2,[minmin2,maxmax2]);title('维纳滤波恢复后的图像');
