%实验1.2：拉普拉斯算子做图像锐化 Laplace
clear all; 
fid = fopen('Eimage-007.img','rb'); 
    C=fread(fid,65536,'float64');
fclose(fid);
for i=1:256
    for j=1:256
        A(i,j)=C((i-1)*256+j);  
    end
end
%A=A';

[n,m]=size(A);
%模板
k1=1;k2=2;k3=3;
H1=1/8*[-1 -1 -1;-1 8*k1 -1;-1 -1 -1];
H2=1/8*[-1 -1 -1;-1 8*k2 -1;-1 -1 -1];
H3=1/8*[-1 -1 -1;-1 8*k3 -1;-1 -1 -1];
%卷积
for i=2:n-1
    for j=2:m-1
        a1=A(i-1:i+1,j-1:j+1).*H1;
        B1(i,j)=sum(sum(a1));
    end
end

for i=2:n-1
    for j=2:m-1
        a2=A(i-1:i+1,j-1:j+1).*H2;
        B2(i,j)=sum(sum(a2));
    end
end

for i=2:n-1
    for j=2:m-1
        a3=A(i-1:i+1,j-1:j+1).*H3;
        B3(i,j)=sum(sum(a3));
    end
end

%显示图像
maxmax=max(max(A));
minmin=min(min(A));
subplot(221);
imshow(A,[minmin,maxmax]);title('原图');
subplot(222);
maxmax1=max(max(B1));
minmin1=min(min(B1));
imshow(B1,[minmin1,maxmax1]);title('k=1');
subplot(223);
maxmax2=max(max(B2));
minmin2=min(min(B2));
imshow(B2,[minmin2,maxmax2]);title('k=2');
subplot(224);
maxmax3=max(max(B3));
minmin3=min(min(B3));
imshow(B3,[minmin3,maxmax3]);title('k=3');




 
