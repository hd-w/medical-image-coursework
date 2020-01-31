%实验2.4：巴特沃斯高通滤波 Butterworth HP filter
clear;
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
g=fftshift(f);
[M,N]=size(f);
n=3;%三阶低通滤波
d0=15;
n1=floor(M/2);
n2=floor(N/2); 
for i=1:M
    for j=1:N
        d=sqrt((i-n1)^2+(j-n2)^2);
        if d0==0
            h=0;
        else
            h=1/(1+(d0/d)^(2*n));
        end
        g(i,j)=h*g(i,j);
    end
end
g=ifftshift(g);
g=real(ifft2(g));
figure;
maxmax1=max(max(g));
minmin1=min(min(g));
imshow(g,[minmin1,maxmax1]);
title('过巴特沃斯高通滤波器后的图像');
        