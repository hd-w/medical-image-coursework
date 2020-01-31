%实验4：用滤波反投影法重建图像 image reconstruction by back projection
clear;
fid = fopen('atten.rad','rb'); 
    C=fread(fid,16384,'float32');
fclose(fid);
for i=1:128
    for j=1:128
        ff(i,j)=C((i-1)*128+j);  
    end
end
figure;
maxmax=max(max(ff));
minmin=min(min(ff));

imshow(ff,[minmin,maxmax]);
title('原投影图')
%滤波-时域上做卷积
n=-128:128;
h1=-2./(pi*pi*(4*n.^2-1));
A=zeros(128,128);
for k=1:128
    for i=1:128
        for j=1:128
            A(k,i)=h1(129+j-i)*ff(k,j)+A(k,i);
        end
    end
end
maxmax2=max(max(A));
minmin2=min(min(A));
figure;
imshow(A,[minmin2,maxmax2]);
title('滤波后投影图')

%反投影
B=zeros(128,128);
    for i=1:128
        q=(2*pi/128)*(i-1);
        for u=1:128
            for v=1:128
                x=(u-64.5)*cos(q)+(v-64.5)*sin(q);
                if -62.5<=x&&x<=63.5
                    c1=A(i,ceil(64.5+x));c2=A(i,floor(64.5+x));
                    B(u,v)=B(u,v)+(c2-c1)*(x-floor(x))+c1;%线性插值
                end
            end
        end
    end
figure;
maxmax1=max(max(B));
minmin1=min(min(B));
imshow(B,[minmin1,maxmax1]);
title('滤波反投影重建图像');