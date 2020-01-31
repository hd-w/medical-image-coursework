%实验2.1：理想低通滤波 ideal low pass filter
close all;
fid = fopen('Eimage-007.img','rb'); 
    C=fread(fid,65536,'float64');
fclose(fid);
for i=1:256
    for j=1:256
        A(i,j)=C((i-1)*256+j);  
    end
end
%A=A';
figure;
maxmax=max(max(A));
minmin=min(min(A));
imshow(A,[minmin,maxmax]);
title('原始图像');

%采用傅里叶变换
f=fft2(A);
%数据矩阵平衡
g=ifftshift(f);
%   g=ifftshift(g);
figure;
% imshow(log(abs(g)),[]);
% title('原始图像的傅里叶频谱');

[M,N]=size(f);
n1=floor(M/2);
n2=floor(N/2); 
d0=45;
for i=1:M
    for j=1:N
        d=sqrt((i-n1)^2+(j-n2)^2);
        if d<=d0
            h=1;
        else
            h=0;
        end
        g(i,j)=h*g(i,j);
    end
end
 g=ifftshift(g);
imshow(log(abs(g)),[]);
title('原始图像的傅里叶频谱');

g=abs(ifft2(g));
figure;
maxmax1=max(max(g));
minmin1=min(min(g));
imshow(g,[minmin1,maxmax1]);
title('过理想低通滤波器后的图像');