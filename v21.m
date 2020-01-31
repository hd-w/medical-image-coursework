%ʵ��2.1�������ͨ�˲� ideal low pass filter
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
title('ԭʼͼ��');

%���ø���Ҷ�任
f=fft2(A);
%���ݾ���ƽ��
g=ifftshift(f);
%   g=ifftshift(g);
figure;
% imshow(log(abs(g)),[]);
% title('ԭʼͼ��ĸ���ҶƵ��');

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
title('ԭʼͼ��ĸ���ҶƵ��');

g=abs(ifft2(g));
figure;
maxmax1=max(max(g));
minmin1=min(min(g));
imshow(g,[minmin1,maxmax1]);
title('�������ͨ�˲������ͼ��');