%ʵ��2.5���ֱ������˲���ά���˲��ָ�ͼ�� inverse filter & Wiener filter
%��ͼ
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
imshow(A,[minmin,maxmax]);title('ԭͼ��');
B=zeros(512,512);
for i=1:256
    for j=1:256
        B(i,j)=A(i,j);
    end
end

F=fftshift(fft2(B));%ԭͼ������ά����Ҷ�任

k1=0.0025;%���˲��е�kֵ
k2=0.001;%ά���˲��е�kֵ
d0=60;%��ͨ�˲���ֹƵ��

[m,n]=size(B);
for u=1:m
    for v=1:n
       H(u,v)=exp(-k1*((u-m/2)^2+(v-n/2)^2)^(5/6));%����չ����
       H2(u,v)=abs(H(u,v))^2;%����ֵ��ƽ��,ά���˲������е�һ����
    end
end
%ͼ��ָ�
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
title('���˲��ָ����ͼ��');


HW=(1./H).*(H2./(H2+k2));   %ά���˲�ϵͳ����
F2=HW.*F;    %ά���˲���ĸ���Ҷ�任
f2=real(ifft2(ifftshift(F2)));  %ά���˲�ͼ��ָ�
for i=1:256
    for j=1:256
           c2(i,j)=f2(i,j);  
    end
end
figure;
maxmax2=max(max(c2));
minmin2=min(min(c2));
imshow(c2,[minmin2,maxmax2]);title('ά���˲��ָ����ͼ��');
